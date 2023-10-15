// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talklytic/Screen/Auth/Data/color_constants.dart';
import 'package:talklytic/Screen/chat_screen.dart';

import '../widgets/Chat_Message_List.dart';

class DesktopScaffold extends StatelessWidget {
  const DesktopScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.account_circle),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Icon(Icons.group),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Icon(Icons.forum),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      PopupMenuButton(
                        // position:,
                        color: ColorConstants.yellowShade,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Text('New group',
                                  style: TextStyle(
                                    color: ColorConstants.blackShade,
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                          ))),
                          PopupMenuItem(
                              child: Text('Select chats',
                                  style: TextStyle(
                                    color: ColorConstants.blackShade,
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                          ))),
                          PopupMenuItem(
                              child: Text('Settings',
                                  style: TextStyle(
                                    color: ColorConstants.blackShade,
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                          ))),
                          PopupMenuItem(
                              child: Text('Logout',
                                  style: TextStyle(
                                    color: ColorConstants.blackShade,
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                          ))),
                        ],
                        child: Icon(Icons.keyboard_arrow_down),
                      )
                    ],
                  ),
                  ChatMessageList(
                    size: size / 3,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: ChatScreen(
                name: 'Vishesh',
                fontSize: 24,
              )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow.shade200,
              child: Column(
                children: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
