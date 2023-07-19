import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_tune_admin/model/product_model/product_model.dart';

import '../../model/uploads_model/category_model.dart';
import '../../serveice/custom_toast.dart';

class ProductSearchProvider extends ChangeNotifier {
  bool isLoading = false;

  bool loadDataFromFirebase = true;
  bool isDataEmpty = false;
  bool showCircularIndicater = false;

  List<ProductModel> products = [];

  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<void> searchProducts({
    required String productName,
  }) async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    if (lastDoc != null) {
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
                isEqualTo: false,
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
                isEqualTo: false,
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

      products.addAll(
        refreshedClass.docs.map((e) {
          return ProductModel.fromFireStore(e);
        }),
      );

      print(products);

      loadDataFromFirebase = false;
      showCircularIndicater = false;
      notifyListeners();
    } catch (e) {
      print(e);
      CustomToast.normalToast('Category not found');
      _cleardata();
      notifyListeners();
    }
  }

  void removeCategory({required CategoryModel category}) {
    products = products
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

  void clearProduct() {
    products.clear();

    lastDoc = null;
    notifyListeners();
  }

  void clearDoc() {
    lastDoc = null;
  }
}
