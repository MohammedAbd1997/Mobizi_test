import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? userId;
  late String? email;
  late String? name;
  late String? imageUrl;
  late String? token;
  late String? result ;

  AppUser({
    this.userId,
    required this.email,
    required this.name,
    this.result ,
    this.imageUrl,
    required this.token,
  });

  factory AppUser.fromMap(Map map) {
    return AppUser(
      userId: map['userId'] ?? "",
      email: map['email'] ?? "",
      name: map['name'] ?? "",
      result: map['result'],
      token: map['token'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'email': this.email,
      'name': this.name,
      'result': this.result,
      'token': this.token,
      'imageUrl': imageUrl,
    };
  }
}
