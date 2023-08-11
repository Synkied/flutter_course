import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  final void Function() startQuiz;

  const StartScreen(this.startQuiz, {super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/quiz-logo.png",
              width: 300, color: const Color.fromARGB(120, 255, 255, 255)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                "Kwizz time!",
                style: GoogleFonts.lato(color: Colors.white, fontSize: 28),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text("Start Kwizz!"),
          ),
        ],
      ),
    );
  }

  void onPressed() {
    startQuiz();
  }
}
