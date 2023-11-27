// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:talklytic/Screen/Auth/Screens/WelcomeScreen.dart';
import 'package:talklytic/Screen/mobile_scaffold.dart';

class MobileAuthScreen extends StatefulWidget {
  const MobileAuthScreen({super.key});

  @override
  State<MobileAuthScreen> createState() => _MobileAuthScreenState();
}

class _MobileAuthScreenState extends State<MobileAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationHomepage(
        LoginScreen: MobileScaffold(),
      ),
    );
  }
}
