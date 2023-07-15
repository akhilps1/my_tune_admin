import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../model/uploads_model/category_model.dart';
import '../../serveice/custom_toast.dart';

class CategorySearchProvider extends ChangeNotifier {
  bool isLoading = false;

  bool loadDataFromFirebase = true;
  bool isDataEmpty = false;
  bool showCircularIndicater = false;

  List<CategoryModel> categories = [];
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<void> searhCategory({
    required String categoryName,
  }) async {
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
              .collection('categories')
              .orderBy('timestamp')
              .where(
                'keywords',
                arrayContains: categoryName,
              )
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('categories')
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

      categories.addAll(
        refreshedClass.docs.map((e) {
          return CategoryModel.fromFireStore(e);
        }),
      );

      loadDataFromFirebase = false;
      showCircularIndicater = false;
      notifyListeners();
    } catch (e) {
      CustomToast.normalToast('Category not found');
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
    categories.clear();
    log(lastDoc.toString());
    notifyListeners();
  }
}
