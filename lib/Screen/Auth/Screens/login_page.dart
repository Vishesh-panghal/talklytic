// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:talklytic/Data/constants/color_constants.dart';
import 'package:talklytic/Screen/splashScreen.dart';
import 'package:talklytic/Screen/Auth/widgets/Text_fields.dart';

import '../../../firebase/firebaseProvider.dart';

class LoginPageScreen extends StatefulWidget {
  Widget LoginScreen;
  LoginPageScreen({
    Key? key,
    required this.LoginScreen,
  }) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool obscureText = true;
  IconData iconData = Icons.visibility_off;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          SizedBox(
            width: size.width * 0.9,
            child: MyTextFieldWidget(
              controller: emailController,
              validator: (value) {
                if (emailController.text.isEmpty) {
                  return 'Please entre a valid email';
                }
                return null;
              },
              hintText: 'Email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black38,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          SizedBox(
            width: size.width * 0.9,
            child: MyTextFieldWidget(
              controller: passwordController,
              validator: (value) {
                if (passwordController.text.isEmpty) {
                  return 'Please entre a valid password';
                }
                return null;
              },
              hintText: 'Password',
              obscureText: obscureText,
              keyboardType: TextInputType.text,
              prefixIcon: Icon(
                Icons.lock_rounded,
                color: Colors.black38,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  obscureText = !obscureText;
                  if (obscureText) {
                    iconData = Icons.visibility_off;
                  } else {
                    iconData = Icons.visibility;
                  }
                  setState(() {});
                },
                child: Icon(
                  iconData,
                  color: obscureText ? Colors.white : Colors.blue,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Forgot Password!')],
            ),
          ),
          SizedBox(height: size.height * 0.05),
          SizedBox(
            width: size.width / 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.purpleShade,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var pref = await SharedPreferences.getInstance();
                  pref.setBool(SplashScreenPage.KEYLOGIN, true);

                  FirebaseProvider().signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    context: context,
                    loginscreen: widget.LoginScreen,
                  );
                }
              },
              child: Text(
                'Login'.toUpperCase(),
                style: TextStyle(
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  color: ColorConstants.whiteShade,
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
