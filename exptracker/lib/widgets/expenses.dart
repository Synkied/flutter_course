import 'package:exptracker/models/expense.dart';
import 'package:exptracker/widgets/chart/chart.dart';
import 'package:exptracker/widgets/expenses_list/expenses_list.dart';
import 'package:exptracker/widgets/new_expense.dart';
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
    final width = MediaQuery.of(context).size.width;

    Widget mainContent =
        const Center(child: Text("No expenses found. Start adding some!"));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter ExpTracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense ${expense.title} removed."),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () => {
            setState(
              () => _registeredExpenses.insert(expenseIndex, expense),
            ),
          },
        ),
      ),
    );
  }
}
