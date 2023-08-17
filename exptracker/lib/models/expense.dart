import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const categoryIcons = {
  ExpenseCategory.animal: Icons.pets,
  ExpenseCategory.travel: Icons.flight_takeoff,
  ExpenseCategory.leisure: Icons.movie,
  ExpenseCategory.work: Icons.work,
  ExpenseCategory.food: Icons.food_bank,
};

const uuid = Uuid();

final formatter = DateFormat.yMd();

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime datetime;
  final ExpenseCategory category;
  Expense({
    required this.title,
    required this.amount,
    required this.datetime,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(datetime);
  }
}

enum ExpenseCategory {
  food,
  travel,
  leisure,
  work,
  animal,
}
