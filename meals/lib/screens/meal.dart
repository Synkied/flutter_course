import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_detail.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;
  final Function(Meal meal) onToggleFavorite;

  const MealDetailScreen({
    Key? key,
    required this.meal,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavorite(meal);
            },
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: MealDetail(meal: meal),
    );
  }
}
