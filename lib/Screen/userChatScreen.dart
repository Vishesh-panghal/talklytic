// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talklytic/Data/Modal/chatRoomModal.dart';
import 'package:talklytic/Data/constants/color_constants.dart';
import 'package:talklytic/firebase/firebaseProvider.dart';

import 'widgets/chatBubble.dart';

class ChatScreen extends StatefulWidget {
  String name;
  double fontSize;
  String toId;
  ChatScreen(
      {super.key, required this.name, this.fontSize = 22, required this.toId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController sendMsgController = TextEditingController();
  bool hasContent = false;
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatStream;

  @override
  void initState() {
    getChatStream();
    super.initState();
  }

  getChatStream() {
    chatStream = FirebaseProvider.getAllMsg(widget.toId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: ColorConstants.purpleShade,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                FontAwesomeIcons.arrowLeft,
                                color: ColorConstants.whiteShade,
                              ),
                            ),
                            SizedBox(width: size.width * 0.1),
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.whiteShade,
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.video,
                                  color: ColorConstants.whiteShade,
                                  size: widget.fontSize / 1.3,
                                ),
                                SizedBox(width: widget.fontSize / 2),
                                Icon(
                                  FontAwesomeIcons.phone,
                                  color: ColorConstants.whiteShade,
                                  size: widget.fontSize / 1.3,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: widget.fontSize / 5),
                                  color: Color.fromARGB(84, 238, 238, 238),
                                  child: VerticalDivider(
                                    indent: 10,
                                    width: 2,
                                    thickness: 1,
                                    color: Colors.red.shade300,
                                    endIndent: 20,
                                  ),
                                ),
                                Icon(
                                  Icons.search,
                                  color: ColorConstants.whiteShade,
                                  size: widget.fontSize / 0.9,
                                ),
                              ],
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: size.width * 0.05),
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.whiteShade,
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  FontAwesomeIcons.video,
                                  color: ColorConstants.whiteShade,
                                  size: widget.fontSize / 1.3,
                                ),
                                SizedBox(width: widget.fontSize / 2),
                                Icon(
                                  FontAwesomeIcons.phone,
                                  color: ColorConstants.whiteShade,
                                  size: widget.fontSize / 1.3,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: widget.fontSize / 5),
                                  color: Color.fromARGB(84, 238, 238, 238),
                                  child: VerticalDivider(
                                    indent: 10,
                                    width: 2,
                                    thickness: 1,
                                    color: Colors.red.shade300,
                                    endIndent: 20,
                                  ),
                                ),
                                Icon(
                                  Icons.search,
                                  color: ColorConstants.whiteShade,
                                  size: widget.fontSize / 0.9,
                                ),
                                SizedBox(width: widget.fontSize / 6),
                                PopupMenuButton(
                                  color: Colors.purple.shade300,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(child: Text('Profile')),
                                    PopupMenuItem(
                                        child: Text('Select message')),
                                    PopupMenuItem(child: Text('Clear chat')),
                                    PopupMenuItem(child: Text('Delete chat')),
                                    PopupMenuItem(child: Text('Report')),
                                    PopupMenuItem(child: Text('Block')),
                                  ],
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: ColorConstants.whiteShade,
                                    size: widget.fontSize / 0.9,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
              SizedBox(height: widget.fontSize),
              Expanded(
                child: Container(
                  // constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      color: ColorConstants.whiteShade,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      )),
                  child: Column(
                    children: [
                      /// =======Msg =========///
                      Expanded(
                          child: StreamBuilder(
                        stream: chatStream,
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            var allMessages = snapshot.data!.docs;
                            return allMessages.isNotEmpty
                                ? ListView.builder(
                                    itemCount: allMessages.length,
                                    itemBuilder: (_, index) {
                                      var currMsg = msgModal
                                          .fromJson(allMessages[index].data());
                                      return Container(
                                          margin: EdgeInsets.only(
                                              top: 12, left: 10),
                                          child: ChatBubble(
                                            message: currMsg,
                                          ));
                                    })
                                : Container();
                          }
                          return Container();
                        },
                      )),

                      /// =======Text Field & more ======//
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 20.0),
                              child: Row(
                                children: [
                                  SpeedDial(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    activeBackgroundColor: Colors.transparent,
                                    useRotationAnimation: true,
                                    activeForegroundColor: Colors.transparent,
                                    spacing: 2,
                                    activeIcon: Icons.add,
                                    children: [
                                      SpeedDialChild(
                                          child: Icon(Icons.location_on)),
                                    ],
                                    child: Icon(Icons.add),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.grey.shade200),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: sendMsgController,
                                              onChanged: (text) {
                                                setState(() {
                                                  hasContent = text.isNotEmpty;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Say Something...',
                                                  hintStyle: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.manrope()
                                                            .fontFamily,
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.faceSmile,
                                              color: Colors.grey.shade700,
                                              size: widget.fontSize,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: widget.fontSize),
                                  hasContent
                                      ? GestureDetector(
                                          onTap: () {
                                            FirebaseProvider.sendMsg(
                                              sendMsgController.text.toString(),
                                              widget.toId,
                                            );
                                            sendMsgController.clear();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ColorConstants.blackShade,
                                            child: Icon(
                                              Icons.send,
                                              color: ColorConstants.whiteShade,
                                              size: widget.fontSize,
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundColor:
                                              ColorConstants.purpleShade,
                                          child: Icon(
                                            Icons.mic,
                                            color: ColorConstants.whiteShade,
                                            size: widget.fontSize / 1.2,
                                          ),
                                        ),
                                ],
                              ),
                            )
                          //=====================Web View========================//
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 20.0),
                              child: Row(
                                children: [
                                  SpeedDial(
                                    activeIcon: Icons.diversity_1_rounded,
                                    children: [
                                      SpeedDialChild(
                                          child: Icon(Icons.location_on)),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.grey.shade200),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: sendMsgController,
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '   Say Something...',
                                                hintStyle: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              FontAwesomeIcons.faceSmile,
                                              color: Colors.grey.shade700,
                                              size: widget.fontSize,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: widget.fontSize),
                                  CircleAvatar(
                                    backgroundColor: ColorConstants.purpleShade,
                                    child: Icon(
                                      Icons.send,
                                      color: ColorConstants.whiteShade,
                                      size: widget.fontSize / 1.2,
                                    ),
                                  ),
                                  SizedBox(width: widget.fontSize),
                                  CircleAvatar(
                                    backgroundColor: ColorConstants.purpleShade,
                                    child: Icon(
                                      Icons.mic,
                                      color: ColorConstants.whiteShade,
                                      size: widget.fontSize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: widget.fontSize),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
