import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../model/uploads_model/category_model.dart';
import '../../serveice/custom_toast.dart';

class CategorySearchProvider extends ChangeNotifier {
  bool isLoading = false;

  bool loadDataFromFirebase = true;
  bool isDataEmpty = false;
  bool showCircularIndicater = false;

  // ProductModel? _productModel;

  // get productModel => _productModel;

  // set setProductModel(ProductModel productModel) {
  //   _productModel = productModel;
  //   categoriesTemp = productModel.craftAndCrew;
  //   notifyListeners();
  // }

  List<CategoryModel> categories = [];
  List<CategoryModel> categoriesTemp = [];

  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<void> searhCategory({
    required String categoryName,
  }) async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    if (lastDoc != null) {
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

  void addCategoryToTemp({
    required CategoryModel category,
  }) {
    CustomToast.successToast('${category.categoryName} added');

    final data = CategoryModel(
      id: category.id,
      isTopTen: category.isTopTen,
      isCraft: category.isCraft,
      visibility: category.visibility,
      categoryName: category.categoryName,
      imageUrl: category.imageUrl,
      timestamp: category.timestamp,
      keywords: category.keywords,
      followers: category.followers,
    );

    categoriesTemp.add(data);

    // print(categoriesTemp);

    notifyListeners();
  }

  void removeCategory({required CategoryModel category}) {
    categories = categories
        .where(
          (element) => element.id != category.id,
        )
        .toList();
    notifyListeners();
  }

  void removeCategoryFromTemp({required CategoryModel category}) {
    categoriesTemp = categoriesTemp
        .where(
          (element) => element.id != category.id,
        )
        .toList();
    notifyListeners();
  }

  void _cleardata() {
    isDataEmpty = true;
    loadDataFromFirebase = false;
    isLoading = false;
    showCircularIndicater = false;
  }

  setCategoryTemp(List<CategoryModel> categories) {
    categoriesTemp = categories;

    // print(categoryList);

    notifyListeners();
  }

  void clearLastDoc() {
    categories.clear();

    lastDoc = null;
    notifyListeners();
  }

  void clearDoc() {
    categories.clear();
    categoriesTemp.clear();
    lastDoc = null;
    notifyListeners();
  }
}

class ChangeRadioValue with ChangeNotifier {
  bool value = true;

  setValue(bool newValue) {
    value = newValue;
    notifyListeners();
  }
}
