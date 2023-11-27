// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:talklytic/Data/constants/color_constants.dart';
import 'package:talklytic/Screen/Auth/Screens/login_page.dart';

import '../../../Bloc/Trending_gif/trending_gif_bloc.dart';
import 'Register_Page.dart';

class AuthenticationHomepage extends StatefulWidget {
  Widget LoginScreen;
  AuthenticationHomepage({
    Key? key,
    required this.LoginScreen,
  }) : super(key: key);

  @override
  State<AuthenticationHomepage> createState() => _AuthenticationHomepageState();
}

class _AuthenticationHomepageState extends State<AuthenticationHomepage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    context.read<TrendingGifBloc>().add(GetTrendingGif());
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.whiteShade,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(children: [
            ClipPath(
              clipper: ClipClipper(),
              child: Container(
                height: size.height * 0.75,
                color: const Color.fromARGB(167, 225, 190, 231),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.2),
                    Container(
                        alignment: Alignment.center,
                        width: size.width,
                        child: Text(
                          'Talkytic'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontSize: 52,
                            color: ColorConstants.blackShade,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 10,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: size.height / 1.8,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: ColorConstants.purpleShade,
                        unselectedLabelColor: ColorConstants.blackShade,
                        tabs: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Login'.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 4,
                                  color: ColorConstants.blackShade,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Signup'.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontSize: 18,
                                  letterSpacing: 4,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.blackShade,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          LoginPageScreen(LoginScreen: widget.LoginScreen),
                          RegisterPageScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ClipClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
