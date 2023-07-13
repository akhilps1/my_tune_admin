import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/model/user_model/user_model.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';

import '../../enums/enums.dart';

class UserPageProvider extends ChangeNotifier {
  final List<AppUser> users = [];
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

  bool loadDataFromFirebase = true;
  bool isLoading = true;
  bool isDataEmpty = false;
  bool showCircularIndicater = false;
  GetUserState currentState = GetUserState.normal;

  Future<void> getUsersByLimit({required GetUserState loadstate}) async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;
    currentState = loadstate;

    if (lastDoc == null) {
      users.clear();
      loadDataFromFirebase = true;
    }
    isLoading = true;
    showCircularIndicater = true;
    isDataEmpty = false;
    notifyListeners();
    try {
      refreshedClass = lastDoc == null
          ? await FirebaseFirestore.instance
              .collection('users')
              .orderBy('timestamp', descending: true)
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('users')
              .orderBy('timestamp', descending: true)
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      // log(refreshedClass.docs.toString());

      if (refreshedClass.docs.length <= 7) {
        isLoading = false;
      }

      users.addAll(
        refreshedClass.docs.map((e) {
          return AppUser.fromSnapshot(e);
        }),
      );
      loadDataFromFirebase = false;
      showCircularIndicater = false;
      notifyListeners();

      // log(users.length.toString());
    } catch (e) {
      _cleardata();

      CustomToast.normalToast('Nothing to show');
      notifyListeners();
    }
  }

  Future<void> searchUserUsingMobileNumber(
      {required String mobileNumber, required GetUserState loadstate}) async {
    currentState = loadstate;
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    if (lastDoc == null) {
      users.clear();
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
              .collection('users')
              .orderBy('timestamp')
              .where('keywords', arrayContains: mobileNumber)
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('users')
              .orderBy('timestamp')
              .where('keywords', arrayContains: mobileNumber)
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      if (refreshedClass.docs.length <= 7) {
        isLoading = false;
      }

      users.addAll(
        refreshedClass.docs.map((e) {
          return AppUser.fromSnapshot(e);
        }),
      );
      loadDataFromFirebase = false;
      showCircularIndicater = false;
      notifyListeners();
    } catch (e) {
      CustomToast.normalToast('No user found');
      _cleardata();
      notifyListeners();
    }
  }

  void clearDoc() {
    lastDoc = null;
  }

  void _cleardata() {
    isDataEmpty = true;
    loadDataFromFirebase = false;
    isLoading = false;
    showCircularIndicater = false;
  }
}
