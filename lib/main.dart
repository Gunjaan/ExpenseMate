import 'package:expense_tracer/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromARGB(255, 48, 82, 71),
        hintColor: const Color.fromARGB(255, 130, 227, 196),
        scaffoldBackgroundColor: const Color(0xFFF9F8F7),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF3E3E3E)),
        ),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.all(16),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
