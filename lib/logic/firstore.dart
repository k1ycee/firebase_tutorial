import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuts/logic/cloud_storage.dart';
import 'package:tuts/model/post.dart';
import 'package:tuts/utils/failure.dart';

class Database {
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  // StreamController<List<Post>> updates = StreamController<List<Post>>.broadcast();
  CloudUpload upload = CloudUpload();

  Future createPost({String? postMessage, File? pickedImage}) async {
    try {
      final uploadResult = await upload.imageUpload(pickedImage);
      return await posts.add(
        // {"post": postMessage}
        Post(
            post: postMessage,
            imageName: uploadResult.imageName,
            uploadUrl: uploadResult.imageUrl).toJson()
      );
    } on FirebaseException {
      throw Failure(message: "Failed to to create a post");
    } on SocketException {
      throw Failure(message: "Internet Connetion failed");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
