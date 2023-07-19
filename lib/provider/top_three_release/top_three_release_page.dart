import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:my_tune_admin/enums/enums.dart';

import 'package:my_tune_admin/model/product_model/product_model.dart';

import '../../serveice/custom_toast.dart';

class TopThreeReleasePageProvider extends ChangeNotifier {
  bool isLoading = false;

  bool loadDataFromFirebase = true;
  bool isDataEmpty = false;
  bool showCircularIndicater = false;

  bool show = true;

  GetDataState state = GetDataState.normal;

  List<ProductModel> products = [];

  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<void> getTodaysReleaseByLimit() async {
    isLoading = true;
    showCircularIndicater = true;
    isDataEmpty = false;
    notifyListeners();

    try {
      FirebaseFirestore.instance
          .collection('products')
          .orderBy('timestamp')
          .where(
            'isTopThree',
            isEqualTo: true,
          )
          .snapshots()
          .listen(
        (event) {
          products.clear();
          for (var element in event.docs) {
            products.add(
              ProductModel.fromFireStore(
                element,
              ),
            );
          }
          notifyListeners();
        },
      );

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

  Future<void> updateTodayRelease({
    required ProductModel productModel,
  }) async {
    isLoading = true;

    products.add(productModel);

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productModel.id)
        .update(
          productModel.copyWith(isTopThree: true).toMap(),
        );

    isLoading = false;
    notifyListeners();
  }

  Future<void> removeTodayRelease({
    required ProductModel productModel,
  }) async {
    isLoading = true;

    products = products
        .where(
          (element) => element.id != productModel.id,
        )
        .toList();

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productModel.id)
        .update(
          productModel.copyWith(isTopThree: false).toMap(),
        );

    isLoading = false;
    notifyListeners();
  }

  Future<void> searchTodaysReleaseByLimit({
    required String productName,
    required bool value,
    GetDataState? getProductState,
  }) async {
    if (getProductState != null) {
      state = getProductState;
    }
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
                'isTodayRelease',
                isEqualTo: value,
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
                'isTodayRelease',
                isEqualTo: value,
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
      print(e);
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
