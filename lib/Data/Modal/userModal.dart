// ignore_for_file: non_constant_identifier_names, file_names

class RegisterModal {
  String? uId;
  String uFirstName;
  String uLastName;
  String uEmail;
  String uPhone;
  String? uProfilePic;
  bool isActive;
  bool isOnline;

  RegisterModal({
    this.uId,
    required this.uFirstName,
    required this.uLastName,
    required this.uEmail,
    required this.uPhone,
    this.uProfilePic,
    this.isActive = true,
    this.isOnline = false,
  });

  factory RegisterModal.fromJson(Map<String, dynamic> json) {
    return RegisterModal(
      uId: json['uId'],
      uFirstName: json['uFirstName'],
      uLastName: json['uLastName'],
      uEmail: json['uEmail'],
      uPhone: json['uPhone'],
      uProfilePic: json['uProfilePic'],
      isActive: json['isActive'],
      isOnline: json['isOnline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'uFirstName': uFirstName,
      'uLastName': uLastName,
      'uEmail': uEmail,
      'uPhone': uPhone,
      'uProfilePic': uProfilePic,
      'isActive': isActive,
      'isOnline': isOnline,
    };
  }
}

class SignInModal {
  String? usrId;
  String uEmail;
  String password;

  SignInModal({required this.uEmail, required this.password});

  factory SignInModal.fromJson(Map<String, String> json) {
    return SignInModal(
      uEmail: 'uEmail',
      password: 'password',
    );
  }
}

// class SingnInWithuPhone {
//   String uPhone;
//   SingnInWithuPhone({required this.uPhone});

//   factory SingnInWithuPhone.fromJson(Map<String, String> json) {
//     return SingnInWithuPhone(uPhone: 'uPhone');
//   }
// }
