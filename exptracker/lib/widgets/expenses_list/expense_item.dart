import 'package:exptracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Text(expense.title),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '\$${expense.amount.toStringAsFixed(2)}',
              ),
              const Spacer(),
              Row(children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(height: 6),
                Text(expense.formattedDate),
              ]),
            ],
          )
        ],
      ),
    ));
  }
}
