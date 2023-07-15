import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/enums/enums.dart';
import 'package:my_tune_admin/failures/main_failures.dart';
import 'package:my_tune_admin/model/product_model/product_model.dart';
import 'package:my_tune_admin/serveice/pick_image_serveice.dart';

import '../../model/uploads_model/category_model.dart';
import '../../serveice/custom_toast.dart';

class ProductPageProvider extends ChangeNotifier {
  String? url;
  bool isLoading = false;
  Either<MainFailures, Uint8List>? failureOrSuccess;

  bool loadDataFromFirebase = true;
  bool isDataEmpty = false;
  bool showCircularIndicater = false;

  bool show = true;

  String? categoryId, categoryName;

  GetCategoryState state = GetCategoryState.normal;

  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

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
          .child('products')
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
        FirebaseFirestore.instance.collection('products');
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
          followers: categoryModel.followers));

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

  Future<void> getCategoriesByLimit({
    required GetCategoryState categoryState,
  }) async {
    state = categoryState;
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
              .collection('products')
              .orderBy('timestamp', descending: true)
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp', descending: true)
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      // log('getCategoriesByLimit: ${refreshedClass.docs.toString()}');

      if (refreshedClass.docs.length <= 7) {
        isLoading = false;
      }

      categories.addAll(
        refreshedClass.docs.map((e) {
          return CategoryModel.fromFireStore(e);
        }),
      );
      // log(categories.toString());

      loadDataFromFirebase = false;
      showCircularIndicater = false;
      notifyListeners();

      // log(users.length.toString());
    } catch (e) {
      isLoading = false;
      isDataEmpty = true;
      showCircularIndicater = false;
      log(e.toString());
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
        followers: categoryModel.followers);

    for (var element in categories) {
      if (element.id == categoryModel.id) {
        element.visibility = value;
        notifyListeners();
      }
    }

    await FirebaseFirestore.instance
        .collection('products')
        .doc(categoryModel.id)
        .update(
          data.toMap(),
        );
  }

  Future<void> updateCategory({required CategoryModel categoryModel}) async {
    isLoading = true;

    for (var element in categories) {
      if (element.id == categoryModel.id) {
        element.imageUrl = categoryModel.imageUrl;
        element.categoryName = categoryModel.categoryName;

        notifyListeners();
      }
    }

    await FirebaseFirestore.instance
        .collection('products')
        .doc(categoryModel.id)
        .update(
          categoryModel.toMap(),
        );
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteCategory({required CategoryModel categoryModel}) async {
    log(categoryModel.id.toString());

    await FirebaseFirestore.instance
        .collection('products')
        .doc(categoryModel.id)
        .delete();

    categories = categories
        .where(
          (element) => element.id != categoryModel.id,
        )
        .toList();
    notifyListeners();
  }

  Future<void> searhCategory({
    required String categoryName,
    required GetCategoryState categoryState,
  }) async {
    state = categoryState;
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    if (lastDoc == null) {
      categories.clear();
      loadDataFromFirebase = true;
      lastDoc = null;
    }
    isLoading = true;
    showCircularIndicater = true;
    isDataEmpty = false;
    notifyListeners();

    try {
      refreshedClass = lastDoc == null
          ? await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp')
              .where(
                'keywords',
                arrayContains: categoryName,
              )
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp')
              .where(
                'keywords',
                arrayContains: categoryName,
              )
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      if (refreshedClass.docs.length <= 7) {
        isLoading = false;
      }
      log('document: ${refreshedClass.docs.toString()}');

      categories.addAll(
        refreshedClass.docs.map((e) {
          return CategoryModel.fromFireStore(e);
        }),
      );
      log('list lenth: ${categories.length}');
      loadDataFromFirebase = false;
      showCircularIndicater = false;
      notifyListeners();
    } catch (e) {
      CustomToast.normalToast('Product not found');
      _cleardata();

      notifyListeners();
    }
  }

  void _cleardata() {
    isDataEmpty = true;
    loadDataFromFirebase = false;
    isLoading = false;
    showCircularIndicater = false;
  }

  void showCategories({
    required bool value,
    required String? categoryId,
    required String? name,
  }) {
    show = value;
    categoryId = categoryId;
    categoryName = name;
    notifyListeners();
  }

  void clearDoc() {
    lastDoc = null;
  }
}
