// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../firebase/firebaseProvider.dart';
import '../../../Data/constants/color_constants.dart';
import '../widgets/Text_fields.dart';

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({super.key});

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextFieldWidget(
                    controller: firstNameController,
                    validator: (value) {
                      if (firstNameController.text.isEmpty) {
                        return 'Please entre a valid name';
                      }
                      return null;
                    },
                    hintText: 'First Name',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: MyTextFieldWidget(
                    controller: lastNameController,
                    validator: (value) {
                      if (lastNameController.text.isEmpty) {
                        return 'Please entre a valid name';
                      }
                      return null;
                    },
                    hintText: 'Last Name',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
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
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: size.width * 0.9,
            child: MyTextFieldWidget(
              controller: phoneController,
              validator: (value) {
                if (phoneController.text.isEmpty) {
                  return 'Please entre a valid phone';
                }
                return null;
              },
              hintText: 'Phone',
              obscureText: false,
              keyboardType: TextInputType.text,
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
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
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: SizedBox(
                    width: size.width * 0.9,
                    child: MyTextFieldWidget(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (confirmPasswordController.text.isEmpty) {
                          return 'Please entre a valid password';
                        }
                        return null;
                      },
                      hintText: 'Confirm Password',
                      obscureText: obscureText,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            width: size.width / 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.purpleShade,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  try {
                    FirebaseProvider().createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      firstNameController: firstNameController.text.trim(),
                      lastNameController: lastNameController.text.trim(),
                      phoneController: phoneController.text.trim(),
                    );
                    _formKey.currentState!.reset();
                  } on FirebaseAuthException catch (e) {
                    print('Error: ${e.code}');
                  }
                }
              },
              child: Text(
                'Register'.toUpperCase(),
                style: TextStyle(
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  color: ColorConstants.whiteShade,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
