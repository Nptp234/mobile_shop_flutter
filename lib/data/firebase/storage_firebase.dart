import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebase{

  String filename = DateTime.now().millisecondsSinceEpoch.toString();

  Future<String?> uploadImage(File file) async{
    try{
      //connect and create path
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Reference reference = firebaseStorage.ref().child('image/$filename');

      //upload
      UploadTask uploadTask = reference.putFile(file);

      //upload progress (optional)
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        log('Upload is ${snapshot.bytesTransferred / snapshot.totalBytes * 100}% complete');
      });

      await uploadTask;
      String? url = await reference.getDownloadURL();
      return url;
    }
    catch(e){
      return '$e';
    }
  }

  Future<bool> deleteImg(String imgUrl) async{
    try{
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Reference reference = firebaseStorage.refFromURL(imgUrl);
      await reference.delete();
      return true;
    }
    catch(e){
      return false;
    }
  }
}