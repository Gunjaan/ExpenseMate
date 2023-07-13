import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work, shopping, bills, other }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.map,
  Category.leisure: Icons.theaters,
  Category.work: Icons.work_outlined,
  Category.shopping: Icons.shopping_cart,
  Category.bills: Icons.receipt,
  Category.other: Icons.category,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalAmount {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    if (sum > 0) {
      return sum;
    } else {
      return 0;
    }
  }

  get totalExpenses => totalAmount;

  IconData? get icon => null;
}
