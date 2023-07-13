import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key, required this.onAddExpense}) : super(key: key);

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: firstDate,
      lastDate: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                Theme.of(context).primaryColor, // Use your app's theme color
            colorScheme: ColorScheme.light(
              primary:
                  Theme.of(context).primaryColor, // Use your app's theme color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Invalid Input',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Error! Please check the values you have entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Okay, got it!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(223, 39, 88, 88),
                ),
              ),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 238, 245, 245),
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 100.0),
      child: ListView(
        children: [
          Text(
            "ExpenseMate",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add a new expense here",
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Expense Description',
              labelStyle: const TextStyle(
                color: Color.fromARGB(223, 6, 14, 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              prefixText: '₹',
              labelStyle: const TextStyle(
                color: Color.fromARGB(223, 10, 22, 22),
              ),
              prefixStyle: const TextStyle(
                color: Color.fromARGB(223, 39, 88, 88),
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(223, 101, 101, 101),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    // ignore: unnecessary_null_comparison
                    _selectedDate == null
                        ? 'Select Date'
                        : DateFormat('MMM d, y').format(_selectedDate),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const Spacer(),
              DropdownButton<Category>(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shadowColor: Colors.grey,
                  foregroundColor: const Color.fromARGB(223, 39, 88, 88),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _submitExpenseData,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
