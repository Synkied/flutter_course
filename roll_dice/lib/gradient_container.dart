import 'package:flutter/material.dart';
import 'package:roll_dice/dice_roller.dart';

const endAlignment = Alignment.bottomRight;
const startAlignment = Alignment.topLeft;

class GradientContainer extends StatelessWidget {
  final List<Color> colors;

  const GradientContainer({super.key, required this.colors});

  GradientContainer.purple({super.key})
      : colors = [
          Colors.deepPurple,
          Colors.indigo,
        ];

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
