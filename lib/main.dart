import 'package:flutter/material.dart';
import 'package:quizzler/Quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: QuizPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];

  void checkAnswer(bool userPikedAnswer) {
    bool CorrectAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
                context: context,
                title: "FINISHED",
                desc: "You Finished the Quiz.")
            .show();
        quizBrain.restart();
        scorekeeper = [];
      } else {
        if (userPikedAnswer == CorrectAnswer) {
          scorekeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scorekeeper.add(
            Icon(Icons.close, color: Colors.red),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              checkAnswer(false);
            },
            child: Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Flase',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              checkAnswer(true);
            },
            child: Container(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'True',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 20,
          width: 20,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: scorekeeper,
            ),
          ),
        )
      ],
    );
  }
}
