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

  String categoryId = '';

  GetDataState state = GetDataState.normal;

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

  Future<void> uploadProductDetails(
      {required ProductModel productModel}) async {
    isLoading = true;
    notifyListeners();

    // final List<Map<String, dynamic>> categories =
    //     productModel.craftAndCrew.map((e) => e.toMap()).toList();

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('products');
    try {
      String id = collectionReference.doc().id;
      // log(id.toString());
      collectionReference.doc(id).set(
            productModel.toMap(),
          );

      // final data = ProductModel(
      //   id: id,
      //   isTodayRelease: productModel.isTodayRelease,
      //   isTopThree: productModel.isTopThree,
      //   categoryId: productModel.categoryId,
      //   title: productModel.title,
      //   description: productModel.description,
      //   imageUrl: productModel.imageUrl,
      //   likes: productModel.likes,
      //   views: productModel.views,
      //   craftAndCrew: productModel.craftAndCrew,
      //   visibility: productModel.visibility,
      //   keywords: productModel.keywords,
      //   timestamp: productModel.timestamp,
      //   categories: productModel.categories,
      // );

      products.add(
        productModel,
      );

      isLoading = false;
      notifyListeners();
    } on SocketException catch (_) {
      isLoading = false;
      notifyListeners();
      CustomToast.errorToast('No internet connection');
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
      CustomToast.errorToast('Error');
    }
  }

  Future<void> getProductsByLimit({
    required GetDataState productState,
    required String id,
  }) async {
    categoryId = id;
    state = productState;
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
              .where(
                'categoryId',
                isEqualTo: id,
              )
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp', descending: true)
              .where(
                'categoryId',
                isEqualTo: id,
              )
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      // log('getCategoriesByLimit: ${refreshedClass.docs.toString()}');

      if (refreshedClass.docs.length <= 7) {
        isLoading = false;
      }

      //   final List<CategoryModel> list = [];
      // data.forEach((key, value) {
      //   list.add(CategoryModel.fromMap(value));
      // });

      products.addAll(
        refreshedClass.docs.map((e) {
          return ProductModel.fromFireStore(e);
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
      // print(e.toString());
      CustomToast.normalToast('Nothing to show');
      notifyListeners();
    }
  }

  Future<void> changeProductVisibility({
    required ProductModel productModel,
    required bool value,
  }) async {
    final data = productModel.copyWith(
      visibility: value,
    );

    for (ProductModel element in products) {
      if (element.id == productModel.id) {
        element.visibility = value;
        notifyListeners();
      }
    }

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productModel.id)
        .update(
          data.toMap(),
        );
  }

  Future<void> updateProductDetails({
    required ProductModel productModel,
  }) async {
    isLoading = true;

    for (var element in products) {
      if (element.id == productModel.id) {
        notifyListeners();
        element.setCategores = productModel.categories;
        element.keywords = productModel.keywords;
        element.description = productModel.description;
        element.imageUrl = productModel.imageUrl;
      }
    }

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productModel.id)
        .update(
          productModel.toMap(),
        );

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteProduct({required ProductModel productModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productModel.id)
          .delete();

      products = products
          .where(
            (element) => element.id != productModel.id,
          )
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> searhProduct({
    required String productName,
    required GetDataState getProductState,
  }) async {
    state = getProductState;
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    if (lastDoc == null) {
      products.clear();
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
                'categoryId',
                isEqualTo: categoryId,
              )
              .where(
                'keywords',
                arrayContains: productName,
              )
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp')
              .where(
                'categoryId',
                isEqualTo: categoryId,
              )
              .where(
                'keywords',
                arrayContains: productName,
              )
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      if (refreshedClass.docs.length <= 7) {
        isLoading = false;
      }
      log('document: ${refreshedClass.docs.toString()}');

      products.addAll(
        refreshedClass.docs.map((e) {
          return ProductModel.fromFireStore(e);
        }),
      );

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

  void clearDoc() {
    lastDoc = null;
  }

  void clearfetcedData() {
    lastDoc = null;
    products.clear();
    notifyListeners();
  }
}
