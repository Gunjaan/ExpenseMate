import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'chart/chart.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 238, 245, 245),
              Color.fromARGB(255, 178, 221, 221),
            ],
          ),
        ),
        child: NewExpense(onAddExpense: _addExpense),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
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
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          // Change the color of the label text to red
          textColor: const Color.fromARGB(255, 147, 237, 243),
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No expenses found!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Add some expenses to get started.',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'assets/images/logo.png', // Replace with the path to your app logo image
            width:
                32, // Adjust the width and height according to your logo's dimensions
            height: 32,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExpenseMate',
                style: TextStyle(
                  color: Color.fromARGB(255, 48, 82, 71),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Simplify your finances!',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 30),
            SizedBox(
              height: 180, // Adjust the height according to your needs
              child: Chart(
                expenses: _registeredExpenses,
              ),
            ),
            Expanded(
              child: mainContent,
            ),
            Text('Made by @gunjaan',
                style: TextStyle(fontSize: 10, color: Colors.grey[600])),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
