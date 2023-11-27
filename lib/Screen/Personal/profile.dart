// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable, camel_case_types, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talklytic/Data/notification_handel.dart';
import 'package:talklytic/Data/constants/color_constants.dart';
import 'package:talklytic/Screen/mobile_scaffold.dart';

class ProfileScreenPage extends StatefulWidget {
  const ProfileScreenPage({super.key});

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPageState();
}

class _ProfileScreenPageState extends State<ProfileScreenPage> {
  File? _img;
  String localImg =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/340px-Default_pfp.svg.png';
  @override
  Widget build(BuildContext context) {
    var notificationService = NotificationServices();

    TextEditingController userNameController = TextEditingController();
    TextEditingController aboutController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController firstDateController = TextEditingController();
    TextEditingController secondDateController = TextEditingController();
    TextEditingController firstMonthController = TextEditingController();
    TextEditingController secondMonthController = TextEditingController();
    TextEditingController firstYearController = TextEditingController();
    TextEditingController secondYearController = TextEditingController();
    TextEditingController thirdYearController = TextEditingController();
    TextEditingController fourthYearController = TextEditingController();
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    Size size = MediaQuery.of(context).size;

    @override
    void initState() {
      notificationService.initlizeNotification((details) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MobileScaffold(),
            ));
      });
      super.initState();
    }

    if (_img != null) {
      print(_img);
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: ColorConstants.purpleShade),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(
                        color: ColorConstants.whiteShade,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        var imgFromGallery = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (imgFromGallery != null) {
                          _img = File(imgFromGallery.path);
                          // print(_img);
                          setState(() {});
                        }
                      } catch (e) {
                        print("Error:- $e");
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: ColorConstants.whiteShade,
                      radius: size.height * 0.08,
                      child: _img != null
                          ? Image.file(_img!)
                          : Image.network(
                              localImg,
                              height: size.height * 0.2,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileTextField(
                      size: size,
                      hintName: 'Username',
                      controller: userNameController,
                    ),
                    SizedBox(height: size.height * 0.01),
                    profileTextField(
                      size: size,
                      hintName: 'Name',
                      controller: nameController,
                    ),
                    SizedBox(height: size.height * 0.01),
                    profileTextField(
                      size: size,
                      hintName: 'About',
                      controller: aboutController,
                    ),
                    SizedBox(height: size.height * 0.01),
                    profileTextField(
                      size: size,
                      hintName: 'Phone',
                      controller: phoneController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Date of Birth',
                      style: TextStyle(
                        color: ColorConstants.blackShade,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(16, 0, 0, 0),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(148, 245, 245, 245)),
                      child: Row(
                        children: [
                          dobInputField(
                            controller: firstDateController,
                            mfocus: false,
                          ),
                          SizedBox(width: size.width * 0.01),
                          dobInputField(
                            controller: secondDateController,
                            mfocus: false,
                          ),
                          SizedBox(width: size.width * 0.01),
                          Text('/'),
                          dobInputField(
                            controller: firstMonthController,
                            mfocus: false,
                          ),
                          SizedBox(width: size.width * 0.01),
                          dobInputField(
                            controller: secondMonthController,
                            mfocus: false,
                          ),
                          SizedBox(width: size.width * 0.01),
                          Text('/'),
                          dobInputField(
                            controller: firstYearController,
                            mfocus: false,
                          ),
                          SizedBox(width: size.width * 0.01),
                          dobInputField(
                            controller: secondYearController,
                            mfocus: false,
                          ),
                          SizedBox(width: size.width * 0.01),
                          dobInputField(
                            controller: thirdYearController,
                            mfocus: false,
                          ),
                          SizedBox(width: size.width * 0.01),
                          dobInputField(
                            controller: fourthYearController,
                            mfocus: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: ColorConstants.blackShade,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Row(
                      children: [
                        Expanded(
                          child: profileTextField(
                            size: size,
                            hintName: 'Current Password',
                            controller: currentPasswordController,
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Expanded(
                          child: profileTextField(
                            size: size,
                            hintName: 'New Password',
                            controller: newPasswordController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              notificationService.sendNotification(
                                  title: 'Deleted',
                                  body: 'Account Deleted Successfully');
                            },
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                color: const Color.fromARGB(164, 244, 67, 54),
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class dobInputField extends StatelessWidget {
  dobInputField({super.key, required this.controller, required this.mfocus});

  TextEditingController controller;
  bool mfocus;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        textAlign: TextAlign.center,
        onChanged: (value) {
          FocusScope.of(context).nextFocus();
        },
        maxLength: 1,
        maxLines: 1,
        autofocus: mfocus,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
        ),
      ),
    );
  }
}

class profileTextField extends StatelessWidget {
  profileTextField(
      {super.key,
      required this.size,
      required this.hintName,
      required this.controller});

  final Size size;
  String hintName;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(16, 0, 0, 0),
          ),
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(148, 245, 245, 245)),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '   $hintName',
          hintStyle: TextStyle(
            color: ColorConstants.blackShade,
            fontFamily: GoogleFonts.manrope().fontFamily,
            fontSize: size.width * 0.03,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
