// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String imageUrl;
  final String videoUrl;
  Timestamp timestamp;
  final String? id;
  BannerModel({
    required this.imageUrl,
    required this.videoUrl,
    required this.timestamp,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'timestamp': timestamp,
    };
  }

  factory BannerModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> map) {
    final data = map.data();
    return BannerModel(
      imageUrl: data['imageUrl'] as String,
      videoUrl: data['videoUrl'] as String,
      id: map.id,
      timestamp: Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'BannerModel(imageUrl: $imageUrl, videoUrl: $videoUrl, timestamp: $timestamp, id: $id)';
  }
}
