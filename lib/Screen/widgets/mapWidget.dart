// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talklytic/Data/Maps/key.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng sourceLocation = LatLng(29.149187, 75.721657);
  static const LatLng targetLocation = LatLng(28.459497, 77.026634);
  Timer? timer;
  int selectedMins = 0;
  bool isTimerVisible = false;

  List<LatLng> polylineCoordinates = [];
  List<String> sendLocationTiming = ['45 min', '1 hour', '5 hour', '8 hour'];

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: MapApiKey.MapKey);

  void getPolyPoints() async {
    await googleMapPolyline.getCoordinatesWithLocation(
      origin: sourceLocation,
      destination: targetLocation,
      mode: RouteMode.walking,
    );
  }

  // void getPolyPoints() async {
  //   try {
  //     PolylinePoints polylinePoints = PolylinePoints();
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       MapApiKey.MapKey,
  //       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //       PointLatLng(targetLocation.latitude, targetLocation.longitude),
  //     );

  //     if (result.points.isNotEmpty) {
  //       result.points.forEach((PointLatLng point) {
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       });
  //     }
  //     setState(() {});
  //   } catch (e) {
  //     print("Error getting route: $e");
  //   }
  // }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Maps',
                  style: TextStyle(
                    fontFamily: GoogleFonts.cinzel().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: sourceLocation,
                  zoom: 8,
                ),
                onMapCreated: (controller) {
                  getPolyPoints();
                },
                polylines: {
                  Polyline(
                    polylineId: PolylineId('route'),
                    points: polylineCoordinates,
                  ),
                },
                markers: {
                  Marker(
                    markerId: MarkerId('Source'),
                    position: sourceLocation,
                  ),
                  Marker(
                    markerId: MarkerId('destination'),
                    position: targetLocation,
                  ),
                },
              ),
            ),
            SizedBox(height: 50),
            CupertinoButton.filled(
              child: Text('Share Location'),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 30,
                        scrollController: FixedExtentScrollController(
                          initialItem: 0,
                        ),
                        children: [
                          Text(sendLocationTiming[0]),
                          Text(sendLocationTiming[1]),
                          Text(sendLocationTiming[2]),
                          Text(sendLocationTiming[3]),
                        ],
                        onSelectedItemChanged: (value) {
                          setState(() {
                            switch (value) {
                              case 0:
                                selectedMins = 45;
                                break;
                              case 1:
                                selectedMins = 60;
                                break;
                              case 2:
                                selectedMins = 300;
                                break;
                              case 3:
                                selectedMins = 480;
                                break;
                              default:
                            }
                          });
                          _startCountdown();
                          Timer(Duration(seconds: 1), () {
                            isTimerVisible = true;
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 40),
            CupertinoButton.filled(
              child: Text('People'),
              onPressed: () {},
            ),
            SizedBox(height: 30),
            AnimatedOpacity(
              opacity: isTimerVisible ? 1 : 0,
              duration: Duration(milliseconds: 100),
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _formatTime(selectedMins *60),
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    color: Colors.white,
                    letterSpacing: 5,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _startCountdown() {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (selectedMins > 0) {
          selectedMins--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 1000;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}



// TweenAnimationBuilder<Duration>(
//   duration: Duration(minutes: 3),
//   tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
//   onEnd: () {
//     print('Timer ended');
//   },
//   builder: (BuildContext context, Duration value, Widget? child) {
//     final minutes = value.inMinutes;
//     final seconds = value.inSeconds % 60;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Text('$minutes:$seconds',
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                color: Colors.black,
//                fontWeight: FontWeight.bold,
//                fontSize: 30)));
//     }),