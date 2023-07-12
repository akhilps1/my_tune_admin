import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../model/uploads_page_model/category_model.dart';
import '../../serveice/custom_toast.dart';

class UploadsPageProvider extends ChangeNotifier {
  String? url;
  bool isLoading = true;

  Future<void> uploadImage({
    required Uint8List bytesImage,
  }) async {
    notifyListeners();

    try {
      FirebaseStorage storage = FirebaseStorage.instance;

      Reference storageRef = storage
          .ref()
          .child('categories')
          .child('${Timestamp.now().microsecondsSinceEpoch}webp_image.jpeg');

      final value = await storageRef.putData(
        bytesImage,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      url = await value.ref.getDownloadURL();

      log(url!);
    } on FirebaseException catch (e) {
      CustomToast.errorToast('error ${e.code}');
    } on SocketException catch (_) {
      CustomToast.errorToast('No internet connection');
    }
  }

  Future<void> uploadCategoryDetails(
      {required CategoryModel categoryModel}) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('banner');
    try {
      await collectionReference.add(categoryModel.toMap());

      isLoading = false;
    } on SocketException catch (_) {
      CustomToast.errorToast('No internet connection');
    } catch (_) {
      CustomToast.errorToast('Error');
    }
    notifyListeners();
  }
}
