// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talklytic/Screen/Auth/widgets/Text_fields.dart';

import '../../../Data/constants/color_constants.dart';

class login_with_phone extends StatelessWidget {
  const login_with_phone({
    super.key,
    required this.size,
    required this.phoneController,
    required this.obscureText,
  });

  final Size size;
  final TextEditingController phoneController;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    var mverificationId = '';
    TextEditingController otp1 = TextEditingController();
    TextEditingController otp2 = TextEditingController();
    TextEditingController otp3 = TextEditingController();
    TextEditingController otp4 = TextEditingController();
    TextEditingController otp5 = TextEditingController();
    TextEditingController otp6 = TextEditingController();
    return Container(
      alignment: Alignment.center,
      height: size.height / 2,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(152, 186, 87, 206),
        Color.fromARGB(170, 239, 229, 87),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Column(
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              color: ColorConstants.blackShade,
              fontSize: 22,
            ),
          ),
          Divider(thickness: 1.5),
          SizedBox(height: size.height * 0.04),
          SizedBox(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? size.width * 0.9
                : size.width / 2,
            child: MyTextFieldWidget(
              controller: phoneController,
              validator: (value) {
                if (phoneController.text.isEmpty &&
                    phoneController.text.length < 10) {
                  return 'Please entre a valid phone number';
                }
                return null;
              },
              hintText: 'Entre your Phone',
              obscureText: false,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? size.width / 2
                : size.width / 8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.yellowShade,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '+91${phoneController.text.toString()}',
                  verificationCompleted: (PhoneAuthCredential credential) {
                    var cred = FirebaseAuth.instance;
                    cred
                        .signInWithCredential(credential)
                        .then((value) => print(value.user!.uid));
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    print('varification failed:${e.message}');
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    mverificationId = verificationId;
                    print('code sent:$verificationId');
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: Text(
                'Send OTP'.toUpperCase(),
                style: TextStyle(
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  color: ColorConstants.blackShade,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          OTP_input_Container(context, otp1, otp2, otp3, otp4, otp5, otp6),
          SizedBox(height: size.height * 0.04),
          SizedBox(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? size.width / 2
                : size.width / 6,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.yellowShade,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onPressed: () {
                if (phoneController.text.isNotEmpty) {
                  if (otp1.text.isNotEmpty &&
                      otp2.text.isNotEmpty &&
                      otp3.text.isNotEmpty &&
                      otp4.text.isNotEmpty &&
                      otp5.text.isNotEmpty &&
                      otp6.text.isNotEmpty) {
                    var otp =
                        '${otp1.text.toString()}${otp2.text.toString()}${otp3.text.toString()}${otp4.text.toString()}${otp5.text.toString()}${otp6.text.toString()}';
                    print('otp: $otp');

                    var cred = PhoneAuthProvider.credential(
                        verificationId: mverificationId, smsCode: otp);
                    var data = FirebaseAuth.instance;
                    data
                        .signInWithCredential(cred)
                        .then((value) => print('data'));
                  }
                }
              },
              child: Text(
                'Login'.toUpperCase(),
                style: TextStyle(
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  color: ColorConstants.blackShade,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row OTP_input_Container(
      BuildContext context,
      TextEditingController otp1,
      TextEditingController otp2,
      TextEditingController otp3,
      TextEditingController otp4,
      TextEditingController otp5,
      TextEditingController otp6) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 21)),
                ),
                child: otpTextField(
                    context: context, controller: otp1, mfocus: true),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 21)),
                ),
                child: otpTextField(
                    context: context, controller: otp2, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 21)),
                ),
                child: otpTextField(
                    context: context, controller: otp3, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 21)),
                ),
                child: otpTextField(
                    context: context, controller: otp4, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 21)),
                ),
                child: otpTextField(
                    context: context, controller: otp5, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 21)),
                ),
                child: otpTextField(
                    context: context, controller: otp6, mfocus: false),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.05,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 10)),
                ),
                child: otpTextField(
                    context: context, controller: otp1, mfocus: true),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.05,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 10)),
                ),
                child: otpTextField(
                    context: context, controller: otp2, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.05,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 10)),
                ),
                child: otpTextField(
                    context: context, controller: otp3, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.05,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 10)),
                ),
                child: otpTextField(
                    context: context, controller: otp4, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.05,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 10)),
                ),
                child: otpTextField(
                    context: context, controller: otp5, mfocus: false),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                width: size.width * 0.05,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShade,
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 10)),
                ),
                child: otpTextField(
                    context: context, controller: otp6, mfocus: false),
              ),
            ],
          );
  }

  Widget otpTextField(
      {required BuildContext context,
      required TextEditingController controller,
      required bool mfocus}) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        if (value.isNotEmpty) {
          FocusScope.of(context).nextFocus();
        }
      },
      textAlign: TextAlign.center,
      maxLines: 1,
      maxLength: 1,
      keyboardType: TextInputType.number,
      autofocus: mfocus,
      decoration: InputDecoration(
        counterText: '',
        border: InputBorder.none,
      ),
    );
  }
}
