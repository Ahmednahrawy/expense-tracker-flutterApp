import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {
  food,
  medicine,
  study,
  fun,
  fixed,
  travel,
  cleaning,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.medicine: Icons.medical_services_rounded,
  Category.study: Icons.school_rounded,
  Category.fun: Icons.movie_filter_outlined,
  Category.fixed: Icons.local_grocery_store,
  Category.travel: Icons.flight,
  Category.cleaning: Icons.clean_hands,
};

class Expense {
  Expense({
    required this.date,
    required this.title,
    required this.amount,
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
  const ExpenseBucket({required this.category, required this.expenses});
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
