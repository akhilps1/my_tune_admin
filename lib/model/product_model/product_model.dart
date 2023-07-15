// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_tune_admin/model/uploads_model/category_model.dart';

class ProductModel {
  final String? id;
  final String title;
  final String description;
  final String imageUrl;
  final int likes;
  final int views;
  final List<CategoryModel> craftAndCrew;
  final String categoryId;
  final List keywords;
  final Timestamp timestamp;
  bool visibility;
  ProductModel({
    this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.views,
    required this.craftAndCrew,
    required this.visibility,
    required this.keywords,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'likes': likes,
      'views': views,
      'craftAndCrew': craftAndCrew.map(
        (e) => e.toMap(),
      ),
      'visibilty': visibility,
      'keywords': keywords,
      'timestamp': timestamp
    };
  }

  factory ProductModel.fromFireStore(
      QueryDocumentSnapshot<Map<String, dynamic>> datas) {
    Map<String, dynamic> data = datas.data();
    return ProductModel(
      id: datas.id,
      categoryId: data['categoryId'] as String,
      title: data['title'] as String,
      visibility: data['visibilty'],
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
      likes: data['likes'] as int,
      views: data['views'] as int,
      craftAndCrew: List.from(
        data['craftAndCrew'].map(
          (e) => CategoryModel.fromMap(e),
        ),
      ),
      keywords: data['keywords'] as List,
      timestamp: data['timestamp'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    int? likes,
    int? views,
    List<CategoryModel>? craftAndCrew,
    String? categoryId,
    List? keywords,
    Timestamp? timestamp,
    bool? visibility,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      craftAndCrew: craftAndCrew ?? this.craftAndCrew,
      categoryId: categoryId ?? this.categoryId,
      keywords: keywords ?? this.keywords,
      timestamp: timestamp ?? this.timestamp,
      visibility: visibility ?? this.visibility,
    );
  }
}
