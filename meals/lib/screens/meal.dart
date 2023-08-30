import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/widgets/meal_detail.dart';

class MealDetailScreen extends ConsumerWidget {
  final Meal meal;

  const MealDetailScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavoriteMeal = favoriteMeals.contains(meal);

    void showInfoMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealsFavoriteStatus(meal);
              showInfoMessage(wasAdded
                  ? "Meal added to favorites"
                  : "Meal removed from favorites");
            },
            icon: AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.9, end: 1).animate(animation),
                  child: child,
                );
              },
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFavoriteMeal ? Icons.star : Icons.star_border,
                key: ValueKey(isFavoriteMeal),
              ),
            ),
          ),
        ],
      ),
      body: MealDetail(meal: meal),
    );
  }
}
