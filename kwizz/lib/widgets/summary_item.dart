import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryItem extends StatelessWidget {
  final correctAnswerColor = const Color.fromARGB(255, 128, 172, 253);
  final wrongAnswerColor = const Color.fromARGB(255, 226, 112, 192);
  final neutralAnswerColor = const Color.fromARGB(255, 213, 176, 255);
  final Map<String, Object> data;

  const SummaryItem(this.data, {super.key});

  Color answerColor(data) {
    return data["correct_answer"] == data["chosen_answer"]
        ? correctAnswerColor
        : wrongAnswerColor;
  }

  @override
  Widget build(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: answerColor(data),
          child: Text(
            ((data['question_idx'] as int) + 1).toString(),
            style: GoogleFonts.lato(
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["question"].toString(),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              const SizedBox(height: 5),
              Text(data["correct_answer"].toString(),
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(color: answerColor(data)))),
              Text(data["chosen_answer"].toString(),
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(color: neutralAnswerColor))),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}
