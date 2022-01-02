import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage;

Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
  //create and ref to the datastructure in Firebase filestorage
 Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

 // when i wont to upload a post to firestore, i create it in that user folder with an unique id so it doesn't get doubled.
 if(isPost) {
   String id = const Uuid().v1();
   ref = ref.child(id);
 }

 //create the uploadtask for Uint8list(needed for webapp)
 UploadTask uploadTask = ref.putData(file);

 //getting the download url from the file. To make it available to every device
 TaskSnapshot snap = await uploadTask;
 String downloadUrl = await snap.ref.getDownloadURL();
 return downloadUrl;
}
}