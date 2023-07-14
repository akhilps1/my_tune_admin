import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:my_tune_admin/model/banner_model/banner_model.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';

class BannerListPageProvider extends ChangeNotifier {
  // this is for storing image path
  Uint8List? bytesFromPicker;

  // this is for storing url of image
  String? url;

  List<BannerModel> bannerList = [];

  bool isLoading = false;

  Future<void> pickImage() async {
    const maxFileSize = 1024 * 199;
    Uint8List? pickedImageBytes = await ImagePickerWeb.getImageAsBytes();
    if (pickedImageBytes != null) {
      if (pickedImageBytes.length <= maxFileSize) {
        bytesFromPicker = pickedImageBytes;
        notifyListeners();
      } else {
        CustomToast.errorToast(
            'this image: ${filesize(pickedImageBytes.length)} | maximum file size allowed is 200KB');
      }
    }
  }

  Future<void> uploadImage({required Uint8List bytesImage}) async {
    isLoading = true;
    notifyListeners();
    // Reference referenceRoot = FirebaseStorage.instance.ref();
    // Reference imageRefernce = referenceRoot.child('banner');
    // Reference imageToUpload = imageRefernce.child(
    //   DateTime.now().millisecondsSinceEpoch.toString(),
    // );
    try {
      // await imageToUpload.putData(bytesImage);
      // url = await imageToUpload.getDownloadURL();

      FirebaseStorage storage = FirebaseStorage.instance;

      Reference storageRef = storage
          .ref()
          .child('banners')
          .child('${Timestamp.now().microsecondsSinceEpoch}jpeg_image.jpeg');

      final value = await storageRef.putData(
        bytesImage,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      url = await value.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      CustomToast.errorToast('error ${e.code}');
    } on SocketException catch (_) {
      CustomToast.errorToast('No internet connection');
    }
  }

  Future<void> uploadBannerDetails({required BannerModel bannerModel}) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('banner');
    try {
      await collectionReference.add(bannerModel.toMap());

      isLoading = false;
    } on SocketException catch (_) {
      CustomToast.errorToast('No internet connection');
    } catch (_) {
      CustomToast.errorToast('Error');
    }
    notifyListeners();
  }

  Future<void> getBannerFromDb() async {
    FirebaseFirestore.instance
        .collection('banner')
        .orderBy('timestamp')
        .snapshots()
        .listen(
      (event) {
        bannerList.clear();
        for (var element in event.docs) {
          bannerList.add(
            BannerModel.fromMap(
              element,
            ),
          );
        }
        notifyListeners();
      },
    );
  }

  Future<void> updateBanner({required BannerModel bannerModel}) async {
    FirebaseFirestore.instance.collection('banner').doc(bannerModel.id).update(
          bannerModel.toMap(),
        );
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteBanner({required BannerModel bannerModel}) async {
    await FirebaseFirestore.instance
        .collection('banner')
        .doc(bannerModel.id)
        .delete();
  }

  void clearData() {
    url = null;
    bytesFromPicker = null;
    isLoading = false;
    notifyListeners();
  }
}
