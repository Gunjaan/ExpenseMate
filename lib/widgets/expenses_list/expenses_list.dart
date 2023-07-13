import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpense,
  }) : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 1, // Adjust the height as needed
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}
