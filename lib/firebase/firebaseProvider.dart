// ignore_for_file: avoid_print, use_build_context_synchronously, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talklytic/Data/Modal/chatRoomModal.dart';

import '../Data/Modal/userModal.dart';

class FirebaseProvider {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseStrore = FirebaseFirestore.instance;

  //====================Collections===========================//
  static const USER_COLLECTION = 'user';
  static const CHATROOM_COLLECTION = 'chat_room';

  static String currUsrId = _firebaseAuth.currentUser!.uid;

//======================Login===============================//
  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required Widget loginscreen,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currUsrId = _firebaseAuth.currentUser!.uid;
      print('Email:-${_firebaseAuth.currentUser!.email}');
      print('UserId:-${_firebaseAuth.currentUser!.uid}');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginscreen,
          ));
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e is FirebaseAuthException && e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e);
      }
    }
  }

//============================Create Account===============================//
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstNameController,
    required String lastNameController,
    required String phoneController,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firebaseStrore
          .collection(USER_COLLECTION)
          .doc(_firebaseAuth.currentUser!.uid)
          .set(
            RegisterModal(
              uId: _firebaseAuth.currentUser!.uid,
              uFirstName: firstNameController,
              uLastName: lastNameController,
              uEmail: email,
              uPhone: phoneController,
            ).toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

//===========================LogOut Account============================//
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

//=========================Get All Users=============================//
  static Future<List<RegisterModal>> getAllUsers() async {
    try {
      List<RegisterModal> arrUsers = [];
      var arrUsersData =
          await _firebaseStrore.collection(USER_COLLECTION).get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> eachUsr
          in arrUsersData.docs) {
        var dataModal = RegisterModal.fromJson(eachUsr.data());
        if (dataModal.uId != _firebaseAuth.currentUser!.uid) {
          arrUsers.add(dataModal);
        }
      }

      return arrUsers;
    } catch (error) {
      print('Error fetching user data: $error');
      rethrow;
    }
  }

//=============================ChatRoom ID ==========================//
  static String getChatId(String fromId, String toId) {
    if (fromId.hashCode <= toId.hashCode) {
      return "${fromId}_$toId";
    } else {
      return "${toId}_$fromId";
    }
  }

//=========================Is Chat Room Exists=======================//
  // static Future<String> chatRoomExist(String fromId, String toId) async {
  //   var allChatRoom =
  //       await _firebaseStrore.collection(CHATROOM_COLLECTION).get();
  //   for (QueryDocumentSnapshot<Map<String, dynamic>> eachChatRoom
  //       in allChatRoom.docs) {
  //     if (createChatId(fromId, toId).contains(eachChatRoom.id)) {
  //       return eachChatRoom.id;
  //     }
  //   }
  //   return '';
  // }

//========================Send Message=============================//
  static void sendMsg(String msg, String toId) {
    var chatId = getChatId(currUsrId, toId);
    var sentTime = DateTime.now().millisecondsSinceEpoch;
    var newMsg = msgModal(
        fromId: currUsrId,
        message: msg,
        msgId: sentTime.toString(),
        toId: toId,
        sent: sentTime.toString());
    _firebaseStrore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection('messages')
        .doc(sentTime.toString())
        .set(newMsg.toJson());
  }

  //=========================Get All Messages=============================//
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMsg(String toId) {
    var chatId = getChatId(currUsrId, toId);

    return _firebaseStrore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection('messages')
        .snapshots();
  }
}
