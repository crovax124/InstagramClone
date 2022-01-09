import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

abstract class FirestoreMethodsInterface {
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage);
  Future<void> likePost(String postId, String uid, List likes);
  Future<void> likeComment(String postId, String commentId, String uid, List likes);
  Future<String> postComment(String postId, String text, String uid, String name, String profilePic);
  Future<String> deletePost(String postId);
  Future<void> followUser(String uid, String followId);
}

abstract class FirestoreConnectionInterface {
  connect();
}
class FirestoreConnection implements FirestoreConnectionInterface {
  @override
  connect() {
    return FirebaseFirestore.instance;
  }
}

class FirestoreMethods implements FirestoreMethodsInterface {
  FirestoreConnectionInterface connection;
  FirestoreMethods(this.connection);

  //upload a post
  @override
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      connection.connect().collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  @override
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await connection.connect().collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await connection.connect().collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> likeComment(
      String postId, String commentId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await connection
            .connect()
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await connection
            .connect()
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        connection
            .connect()
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'likes': []
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await connection.connect().collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await connection.connect().collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await connection.connect().collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await connection.connect().collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await connection.connect().collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await connection.connect().collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
