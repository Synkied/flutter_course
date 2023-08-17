import 'package:exptracker/models/expense.dart';
import 'package:exptracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 19.99,
      datetime: DateTime.now(),
      category: ExpenseCategory.leisure,
    ),
    Expense(
      title: 'Shanghai trip',
      amount: 3050,
      datetime: DateTime.now(),
      category: ExpenseCategory.work,
    ),
    Expense(
      title: 'Foodolist groceries list',
      amount: 108.50,
      datetime: DateTime.now(),
      category: ExpenseCategory.food,
    ),
    Expense(
      title: 'Veterinarian',
      amount: 300.50,
      datetime: DateTime.now(),
      category: ExpenseCategory.animal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Charts"),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
