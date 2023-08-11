import 'package:flutter/material.dart';
import 'package:kwizz/data/questions.dart';
import 'package:kwizz/widgets/questions_screen.dart';
import 'package:kwizz/widgets/results_screen.dart';
import 'package:kwizz/widgets/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var displayedScreen = "start-screen";

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(startQuiz);

    if (displayedScreen == "questions-screen") {
      selectedAnswers = [];
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (displayedScreen == "results-screen") {
      screenWidget =
          ResultsScreen(chosenAnswers: selectedAnswers, startQuiz: startQuiz);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.deepPurple),
          child: screenWidget,
        ),
      ),
    );
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        displayedScreen = "results-screen";
      });
    }
  }

  void startQuiz() {
    setState(() {
      displayedScreen = "questions-screen";
    });
  }
}
