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

  bool loadDataFromFirebase = true;
  bool isDataEmpty = false;
  bool showCircularIndicater = false;

  List<CategoryModel> categories = [];
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

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
      String id = collectionReference.doc().id;
      log(id.toString());
      collectionReference.doc(id).set(categoryModel.toMap());

      categories.add(CategoryModel(
        id: id,
        visibility: categoryModel.visibility,
        categoryName: categoryModel.categoryName,
        imageUrl: categoryModel.imageUrl,
        timestamp: categoryModel.timestamp,
        keywords: categoryModel.keywords,
      ));

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
  }

  Future<void> getCategoriesByLimit() async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    if (lastDoc == null) {
      loadDataFromFirebase = true;
    }
    isLoading = true;
    showCircularIndicater = true;
    isDataEmpty = false;
    notifyListeners();
    try {
      refreshedClass = lastDoc == null
          ? await FirebaseFirestore.instance
              .collection('categories')
              .orderBy('timestamp', descending: true)
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('categories')
              .orderBy('timestamp', descending: true)
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      log(refreshedClass.docs.toString());

      if (refreshedClass.docs.length <= 7) {
        isLoading = false;
      }

      categories.addAll(
        refreshedClass.docs.map((e) {
          return CategoryModel.fromFireStore(e);
        }),
      );
      log(categories.toString());

      loadDataFromFirebase = false;
      showCircularIndicater = false;
      notifyListeners();

      // log(users.length.toString());
    } catch (e) {
      isLoading = false;
      isDataEmpty = true;
      showCircularIndicater = false;
      CustomToast.normalToast('Nothing to show');
      notifyListeners();
    }
  }

  Future<void> changeCategoryVisibility({
    required CategoryModel categoryModel,
    required bool value,
  }) async {
    final data = CategoryModel(
      visibility: value,
      categoryName: categoryModel.categoryName,
      imageUrl: categoryModel.imageUrl,
      timestamp: categoryModel.timestamp,
      keywords: categoryModel.keywords,
    );

    // final category = categories.where(
    //   (element) => element.id == categoryModel.id,
    // // );
    // final category = categories.map((e) => null)

    for (var element in categories) {
      if (element.id == categoryModel.id) {
        element.visibility = value;
        notifyListeners();
      }
    }

    await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryModel.id)
        .update(data.toMap());
  }
}