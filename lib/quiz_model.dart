import 'dart:convert';

class QuizModel {
  String question;
  List<String> answers;
  int correctIndex;

  QuizModel({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
      'correctIndex': correctIndex,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      question: map['question'] ?? '',
      answers: List<String>.from(map['answers']),
      correctIndex: map['correctIndex']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
