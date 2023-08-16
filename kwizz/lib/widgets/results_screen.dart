import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwizz/data/questions.dart';
import 'package:kwizz/widgets/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> chosenAnswers;
  final void Function() startQuiz;

  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.startQuiz});

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          "question_idx": i,
          "question": questions[i].text,
          "correct_answer": questions[i].answers[0],
          "chosen_answer": chosenAnswers[i],
        },
      );
    }

    return summary;
  }

  @override
  Widget build(context) {
    final numTotalQuestions = questions.length;
    final numCorrectAnswers = summaryData
        .where((data) => data["correct_answer"] == data["chosen_answer"])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered to $numCorrectAnswers out of $numTotalQuestions questions correctly!",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 239, 220, 255),
                  fontSize: 18,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData: summaryData),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: startQuiz,
              icon: const Icon(Icons.restart_alt),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              label: Text("Restart Kwizz!", style: GoogleFonts.lato()),
            )
          ],
        ),
      ),
    );
  }
}
