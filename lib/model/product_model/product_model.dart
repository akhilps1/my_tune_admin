// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tune_admin/model/uploads_model/category_model.dart';

class ProductModel {
  final String? id;
  String title;
  String description;
  String imageUrl;
  final int likes;
  final int views;
  Map<String, Map<String, dynamic>> craftAndCrew;

  List<CategoryModel>? categories;

  final String categoryId;
  List keywords;
  final Timestamp timestamp;
  bool visibility;
  ProductModel({
    this.id,
    this.categories,
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
      'craftAndCrew': craftAndCrew,
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
      visibility: data['visibilty'] as bool,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
      likes: data['likes'] as int,
      views: data['views'] as int,
      craftAndCrew: Map.from(
        data['craftAndCrew'],
      ),
      keywords: data['keywords'] as List,
      timestamp: data['timestamp'] as Timestamp,
      categories: convertMap(
        Map.from(data['craftAndCrew']),
      ),
    );
  }

  static List<CategoryModel> convertMap(
      Map<String, Map<String, dynamic>> data) {
    final List<CategoryModel> list = [];
    data.forEach((key, value) {
      list.add(CategoryModel.fromMap(value));
    });
    return list;
  }

  String toJson() => json.encode(toMap());

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    int? likes,
    int? views,
    Map<String, Map<String, dynamic>>? craftAndCrew,
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
