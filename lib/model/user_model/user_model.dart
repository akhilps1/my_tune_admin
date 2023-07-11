// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String userName;
  final String imageUrl;
  final String mobileNumber;
  final String email;
  final String age;
  final String city;
  final String favorateSinger;
  final List skills;
  final List hobbies;
  final List keywords;
  Timestamp timestamp;
  AppUser({
    required this.userName,
    required this.imageUrl,
    required this.mobileNumber,
    required this.email,
    required this.age,
    required this.city,
    required this.skills,
    required this.hobbies,
    required this.favorateSinger,
    required this.timestamp,
    required this.keywords,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'imageUrl': imageUrl,
      'mobileNumber': mobileNumber,
      'email': email,
      'age': age,
      'city': city,
      'favorateSinger': favorateSinger,
      'skills': skills,
      'hobbies': hobbies,
      'timestamp': timestamp,
      'keywords': keywords,
    };
  }

  factory AppUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final map = snap.data()!;
    return AppUser(
      userName: map['userName'] as String,
      imageUrl: map['imageUrl'] as String,
      mobileNumber: map['mobileNumber'] as String,
      email: map['email'] as String,
      age: map['age'] as String,
      city: map['city'] as String,
      favorateSinger: map['favorateSinger'] as String,
      skills: map['skills'] as List,
      hobbies: map['hobbies'] as List,
      timestamp: map['timestamp'] as Timestamp,
      keywords: map['keywords'] as List,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AppUser(userName: $userName, imageUrl: $imageUrl, mobileNumber: $mobileNumber, email: $email, age: $age, city: $city, favorateSinger: $favorateSinger, skills: $skills, hobbies: $hobbies, timestamp: $timestamp, keywords: $keywords)';
  }
}
