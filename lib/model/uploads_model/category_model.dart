// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryModel {
  final String? id;
  bool visibility;
  String categoryName;
  String imageUrl;
  final num followers;
  final Timestamp timestamp;
  final List keywords;
  bool isCraft;
  CategoryModel({
    required this.visibility,
    required this.categoryName,
    required this.imageUrl,
    required this.timestamp,
    required this.keywords,
    required this.followers,
    this.id,
    this.isCraft = true,
  });

  void changeCraftOrCrew() {
    isCraft = !isCraft;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'visibility': visibility,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'keywords': keywords,
      'followers': followers,
      'isCraft': isCraft,
    };
  }

  factory CategoryModel.fromFireStore(
      QueryDocumentSnapshot<Map<String, dynamic>> data) {
    Map<String, dynamic> map = data.data();
    return CategoryModel(
      id: data.id,
      followers: map['followers'] as num,
      visibility: map['visibility'] as bool,
      categoryName: map['categoryName'] as String,
      imageUrl: map['imageUrl'] as String,
      timestamp: map['timestamp'] as Timestamp,
      keywords: map['keywords'] as List,
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      followers: map['followers'] as num,
      visibility: map['visibility'] as bool,
      categoryName: map['categoryName'] as String,
      imageUrl: map['imageUrl'] as String,
      timestamp: map['timestamp'] as Timestamp,
      keywords: map['keywords'] as List,
      isCraft: map['isCraft'],
    );
  }
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.visibility == visibility &&
        other.categoryName == categoryName &&
        other.imageUrl == imageUrl &&
        other.followers == followers &&
        other.timestamp == timestamp &&
        listEquals(other.keywords, keywords);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        visibility.hashCode ^
        categoryName.hashCode ^
        imageUrl.hashCode ^
        followers.hashCode ^
        timestamp.hashCode ^
        keywords.hashCode;
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, visibility: $visibility, categoryName: $categoryName, imageUrl: $imageUrl, followers: $followers, timestamp: $timestamp, keywords: $keywords, isCraft: $isCraft)';
  }
}
