import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String? id;
  late String? name;
  late String? answer;
  late String? description;
  int selectedAnswer = -1;
  final Timestamp? dateTime;
  late List<dynamic>? choice = [];

  Question({
    this.id,
    required this.name,
    required this.answer,
    this.description,
    required this.dateTime,
    this.choice,
  });

  factory Question.fromMap(Map map) {
    return Question(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      answer: map['answer'] ?? "",
      dateTime: map['dateTime'] ?? Timestamp.now(),
      choice: map['choice'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'answer': answer,
      'description': description,
      'dateTime': this.dateTime,
      'choice': this.choice,
    };
  }
}
