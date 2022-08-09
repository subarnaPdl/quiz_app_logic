import 'package:flutter/material.dart';
import 'package:quiz_app_logic/quiz_json.dart';
import 'package:quiz_app_logic/quiz_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _totalQuestions = 0;
  int _totalCorrectAnswers = 0;

  int _currentQuestionIndex = 0;
  int _correctTileIndex = 0;
  int _pressedTileIndex = 0;

  bool _isInitial = true;

  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _totalQuestions = quiz.length;
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _totalQuestions,
            itemBuilder: ((context, index) {
              _currentQuestionIndex = index + 1;
              final QuizModel currentQuestionData =
                  QuizModel.fromMap(quiz[index]);
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _questionCounter(),
                    const SizedBox(height: 10),
                    Text(
                      currentQuestionData.question,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    _answersList(currentQuestionData),
                    const SizedBox(height: 15),
                    _bottomButton(index),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _questionCounter() {
    return Text(
      "$_currentQuestionIndex / $_totalQuestions",
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _answersList(QuizModel currentQuestionData) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        final List answersList = currentQuestionData.answers;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(answersList[index]),
            tileColor: _isInitial
                ? Colors.grey[200]
                : (index == _correctTileIndex)
                    ? Colors.green
                    : (index == _pressedTileIndex &&
                            _pressedTileIndex != _correctTileIndex)
                        ? Colors.red
                        : Colors.grey[200],
            onTap: () {
              if (_isInitial) {
                setState(() {
                  _pressedTileIndex = index;
                  _correctTileIndex = currentQuestionData.correctIndex;
                  _isInitial = false;

                  if (_pressedTileIndex == _correctTileIndex) {
                    _totalCorrectAnswers += 1;
                  }
                });
              }
            },
          ),
        );
      }),
    );
  }

  Widget _bottomButton(int index) {
    return _currentQuestionIndex < _totalQuestions
        ? ElevatedButton(
            child: const Text("    Next    "),
            onPressed: () {
              _pageController.jumpToPage(index + 1);
              setState(() {
                _pressedTileIndex = 0;
                _correctTileIndex = 0;
                _isInitial = true;
              });
            },
          )
        : ElevatedButton(
            child: const Text("    View Result    "),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text(
                        "Correct answers = $_totalCorrectAnswers / $_totalQuestions",
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  });
            },
          );
  }
}
