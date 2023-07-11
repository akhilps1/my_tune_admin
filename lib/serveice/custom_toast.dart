import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void normalToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      webBgColor: "linear-gradient(to right, #000000, #000000)",
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  static void errorToast(String msg) {
      Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      webBgColor: "linear-gradient(to right, #dc1c13, #f53e01)",
      textColor: Colors.white,
      fontSize: 16,
    );
  }
  static void successToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      // webBgColor: "linear-gradient(to right, #0dfc2d, #f53e01)",
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
