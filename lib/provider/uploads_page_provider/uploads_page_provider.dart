import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/failures/main_failures.dart';
import 'package:my_tune_admin/serveice/pick_image_serveice.dart';

import '../../model/uploads_page_model/category_model.dart';
import '../../serveice/custom_toast.dart';

class UploadsPageProvider extends ChangeNotifier {
  String? url;
  bool isLoading = false;
  Either<MainFailures, Uint8List>? failureOrSuccess;

  Future<void> pickImage() async {
    failureOrSuccess = await PickImageServeice.pickImage();
  }

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
    isLoading = true;
    notifyListeners();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('categories');
    try {
      await collectionReference.add(categoryModel.toMap());

      isLoading = false;
      notifyListeners();
    } on SocketException catch (_) {
      isLoading = false;
      notifyListeners();
      CustomToast.errorToast('No internet connection');
    } catch (_) {
      isLoading = false;
      notifyListeners();
      CustomToast.errorToast('Error');
    }
    notifyListeners();
  }
}
