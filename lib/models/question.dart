import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Question {
  final String id;
  final String question;
  final List<String> answers;
  final String correctAnswer;
  final String subject;
  Question(
      {required this.id,
      required this.question,
      required this.answers,
      required this.correctAnswer,
      required this.subject});

  Question copyWith(
      {String? id,
      String? question,
      List<String>? answers,
      String? correctAnswer,
      String? subject}) {
    return Question(
        id: id ?? this.id,
        question: question ?? this.question,
        answers: answers ?? this.answers,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        subject: subject ?? this.subject);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
      'subject': subject
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        id: map['id'],
        question: map['question'],
        answers: List<String>.from(map['answers']),
        correctAnswer: map['correctAnswer'],
        subject: map['subject']);
  }

  factory Question.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;
    return Question.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answers: $answers, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.id == id &&
        other.question == question &&
        listEquals(other.answers, answers) &&
        other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        answers.hashCode ^
        correctAnswer.hashCode;
  }
}
