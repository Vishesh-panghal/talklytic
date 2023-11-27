// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talklytic/Data/constants/color_constants.dart';
import 'package:talklytic/Screen/Auth/Screens/WelcomeScreen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:talklytic/Screen/desktop_scaffold.dart';

class DesktopAuthScreen extends StatefulWidget {
  const DesktopAuthScreen({super.key});

  @override
  State<DesktopAuthScreen> createState() => _DesktopAuthScreenState();
}

class _DesktopAuthScreenState extends State<DesktopAuthScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorConstants.blackShade,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AvatarGlow(
                        endRadius: 100,
                        duration: Duration(milliseconds: 2000),
                        repeatPauseDuration: Duration(milliseconds: 700),
                        // repeat: false,
                        child: Image.asset(
                          'assets/app_icon.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      SizedBox(),
                      Text(
                        '"In a world of pixels, be the one who clicks."',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontSize: size.width * 0.01,
                          wordSpacing: 5,
                        ),
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: AuthenticationHomepage(
                LoginScreen: DesktopScaffold(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
