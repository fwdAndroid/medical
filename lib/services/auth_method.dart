import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical/model/user_model.dart';
import 'package:medical/services/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //Register User with Add User
  Future<String> signUpUser(
      {required String email,
      required String pass,
      required String hospitalName,
      required String username,
      required String dob,
      required Uint8List file}) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          pass.isNotEmpty ||
          hospitalName.isNotEmpty ||
          username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);
        String photoURL = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);
        //Add User to the database with modal
        UserModel userModel = UserModel(
            name: username,
            uid: cred.user!.uid,
            email: email,
            hospitalName: hospitalName,
            photo: photoURL,
            dob: dob,
            password: pass);
        await firebaseFirestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(userModel.toJson());
        res = 'sucess';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  ///Login User with Add Useer
  Future<String> loginUpUser({
    required String email,
    required String pass,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: pass);

        res = 'sucess';
      }
    } on FirebaseException catch (e) {
      if (e == 'WrongEmail') {
        print(e.message);
      }
      if (e == 'WrongPassword') {
        print(e.message);
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
