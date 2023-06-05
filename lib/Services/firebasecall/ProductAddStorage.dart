import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProductStorage {
  Future<List<String>> uploadImages(
      List<File> pickedImages, String name) async {
    List<String> imagesDownloadPaths = [];
    final _fierbaseStorage = FirebaseStorage.instance;

    //Check for Permission
    if (pickedImages.isNotEmpty) {
      //Upload to FireBase
      for (int i = 0; i < pickedImages.length; i++) {
        var snapshot = await _fierbaseStorage
            .ref()
            .child('AppPictures/NewFolder/${name}$i')
            .putFile(pickedImages[i]);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imagesDownloadPaths.add(downloadUrl);
      }
      return imagesDownloadPaths;
    } else {
      print('no image path found ');
      return [''];
    }
  }

  // then just call it from where you like
}
