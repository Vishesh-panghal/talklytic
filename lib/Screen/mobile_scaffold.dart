// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:talklytic/Screen/Auth/Responsive/mobile_view.dart';
import 'package:talklytic/Data/constants/color_constants.dart';
import 'package:talklytic/Screen/splashScreen.dart';

import '../firebase/firebaseProvider.dart';
import 'Personal/profile.dart';
import 'Personal/settings.dart';
import 'widgets/availableUserList.dart';

class MobileScaffold extends StatelessWidget {
  MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SpeedDial(
        activeIcon: Icons.clear,
        activeBackgroundColor: Colors.redAccent,
        backgroundColor: ColorConstants.purpleShade,
        children: [
          SpeedDialChild(child: Icon(Icons.group), label: 'New chat'),
          SpeedDialChild(child: Icon(Icons.group), label: 'New group'),
        ],
        child: Icon(Icons.forum, color: ColorConstants.whiteShade),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: ColorConstants.purpleShade,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi,Vishesh!'.toUpperCase(),
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    fontSize: 15,
                                    color: ColorConstants.whiteShade,
                                    letterSpacing: 3),
                              ),
                              SizedBox(height: size.height * 0.001),
                              Text(
                                'You Recevied',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontSize: 18,
                                  color: ColorConstants.whiteShade,
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileScreenPage(),
                                          )),
                                      child: Text('Profile'))),
                              PopupMenuItem(
                                  child: GestureDetector(
                                      // onTap: () => Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           // AppSettingPage(),
                                      //     ),),
                                      child: Text('Setting'))),
                              PopupMenuItem(
                                  child: GestureDetector(
                                      onTap: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        pref.setBool(
                                            SplashScreenPage.KEYLOGIN, false);
                                        FirebaseProvider().signOut();
                                        Timer(Duration(milliseconds: 700), () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MobileAuthScreen()));
                                        });
                                      },
                                      child: Text('Logout'))),
                            ],
                            child: Icon(
                              Icons.account_circle,
                              color: ColorConstants.yellowShade,
                              size: size.width * 0.08,
                            ),
                          )
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '48',
                          style: TextStyle(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontSize: 24,
                            color: ColorConstants.yellowShade,
                            letterSpacing: 5,
                          ),
                          children: [
                            TextSpan(
                              text: 'message',
                              style: TextStyle(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                fontSize: 24,
                                color: ColorConstants.whiteShade,
                                letterSpacing: 5,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),
                      SizedBox(
                        height: size.height * 0.15,
                        width: size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              height: 54,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    foregroundImage: const NetworkImage(
                                        'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
                                    radius: size.height * 0.05,
                                  ),
                                  Text(
                                    'Vishesh',
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                      fontSize: 15,
                                      color: ColorConstants.whiteShade,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ChatMessageList(size: size),
            ],
          ),
        ),
      ),
    );
  }
}
