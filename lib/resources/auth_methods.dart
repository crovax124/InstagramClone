import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,

}) async {
    String res ="Some error occured";
    try{//basic regex to check is empty
if(email.isEmpty || password.isEmpty || username.isEmpty || bio.isEmpty || file != null) {
  //register user in firebase
  UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

  //add user to our database
_firestore.
}

    }
    catch(err) {
      res = err.toString();
    }
      return res;
    }
  }
