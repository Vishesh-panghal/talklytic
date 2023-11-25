// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, constant_identifier_names, file_names

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talklytic/Screen/Auth/Data/color_constants.dart';
import 'package:talklytic/Screen/Auth/Screens/Responsive/mobile_view.dart';
import 'package:talklytic/Screen/mobile_scaffold.dart';

import 'Bloc/Trending_gif/trending_gif_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  static const String KEYLOGIN = 'login';
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String text = '';
  int currIndex = 0;
  final String quoteText = '"In a world of pixels, be the one who clicks."';

  @override
  void initState() {
    context.read<TrendingGifBloc>().add(GetTrendingGif());
    _controller = AnimationController(vsync: this);
    _startTypingAnimation();
    checkAuth();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> checkAuth() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool? loginStatus = pref.getBool(SplashScreenPage.KEYLOGIN) ?? false;
      print(loginStatus);
      if (loginStatus) {
        Future.delayed(
          Duration(seconds: 3),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MobileScaffold(),
              ),
            );
          },
        );
      } else {
        Future.delayed(
          Duration(seconds: 3),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MobileAuthScreen(),
              ),
            );
          },
        );
      }
    } catch (e) {
      print("Error initializing SharedPreferences: $e");
    }
  }

  void _startTypingAnimation() {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        if (currIndex < quoteText.length) {
          setState(() {
            text += quoteText[currIndex];
            currIndex++;
          });
          _startTypingAnimation();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.whiteShade,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),
              AvatarGlow(
                glowColor: Colors.grey,
                endRadius: 100,
                duration: Duration(milliseconds: 2000),
                repeatPauseDuration: Duration(milliseconds: 700),
                repeat: false,
                child: Image.asset(
                  'assets/app_icon.png',
                  height: 200,
                  width: 200,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: size.height * 0.015,
                      wordSpacing: 3,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
