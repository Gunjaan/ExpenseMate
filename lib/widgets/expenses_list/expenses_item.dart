import 'package:expense_tracer/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key}) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 124, 124, 124).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(15 / 360),
                    child: Icon(
                      categoryIcons[expense.category],
                      color: Color.fromARGB(255, 40, 62, 55),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    expense.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    '₹${expense.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 84, 145, 125),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    expense.formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 84, 145, 125),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
