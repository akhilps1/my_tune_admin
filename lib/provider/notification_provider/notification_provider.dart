import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:my_tune_admin/serveice/custom_toast.dart';
import 'package:provider/provider.dart';

import '../../general/app_details.dart';
import '../banner_list_provider/banner_list_page_provider.dart';

class NotificationProvider extends ChangeNotifier {
  bool? isSending = false;
  Future<void> callOnFcmApiSendPushNotifications({
    required BuildContext context,
    required String title,
    required String body,
  }) async {
    isSending = true;
    notifyListeners();
    String? url;
    Uint8List? image =
        Provider.of<BannerListPageProvider>(context, listen: false)
            .bytesFromPicker;
    if (Provider.of<BannerListPageProvider>(context, listen: false)
            .bytesFromPicker !=
        null) {
      await Provider.of<BannerListPageProvider>(context, listen: false)
          .uploadImage(bytesImage: image!);
    }
    FirebaseFirestore.instance.collection("notification").doc().set({
      "image": url,
      "msg": body,
      "title": title,
      "timestamp": Timestamp.now(),
    });

    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/admin",
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "priority": "high",
      "notification": {
        "title": title,
        "body": body,
        "content_available": true,
        // "sound":"order.mp3",
        //"playSound": true,
        "android_channel_id": "notification_channel_fcm",
        "image": "$url"
      },
      "data": {
        // "type": '0rder',
        // "id": '28',
        // "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      },
      "apns": {
        "headers": {
          "apns-priority": "10",
          "apns-push-type": "background",
        },
        "payload": {
          "aps": {"content-available": 1}
        }
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=${AppDetails.apiKey}' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      // on success do sth
      // print('test ok push CFM');
      CustomToast.successToast('Notification sent successfully.');
    }
    isSending = false;
    notifyListeners();
  }
}
