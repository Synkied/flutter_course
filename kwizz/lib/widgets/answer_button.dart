import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
