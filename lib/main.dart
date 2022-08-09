import 'package:flutter/material.dart';
import 'package:quiz_app_logic/quizpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Quiz App Logic',
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}
