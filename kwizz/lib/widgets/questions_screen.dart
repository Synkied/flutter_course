import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwizz/data/questions.dart';
import 'package:kwizz/widgets/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  final void Function(String answer) onSelectAnswer;

  const QuestionsScreen({super.key, required this.onSelectAnswer});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion() {
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                textStyle:
                    const TextStyle(color: Color.fromARGB(255, 193, 151, 233)),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                  text: answer,
                  onTap: () {
                    answerQuestion();
                    widget.onSelectAnswer(answer);
                  });
            })
          ],
        ),
      ),
    );
  }
}
