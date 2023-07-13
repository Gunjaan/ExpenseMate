import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.shopping),
      ExpenseBucket.forCategory(expenses, Category.bills),
      ExpenseBucket.forCategory(expenses, Category.other),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    if (buckets.isEmpty) {
      maxTotalExpense = 0;
    } else {
      maxTotalExpense = buckets
          .reduce((bucket1, bucket2) =>
              bucket1.totalExpenses > bucket2.totalExpenses ? bucket1 : bucket2)
          .totalExpenses;
    }

    for (final bucket in buckets) {
      if (bucket.totalExpenses != null &&
          bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 138, 189, 190),
            Color.fromARGB(255, 221, 245, 237),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: maxTotalExpense == 0
                        ? 0.00001
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets // for ... in
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(categoryIcons[bucket.category],
                          color: isDarkMode
                              ? Color.fromARGB(255, 42, 66, 62)
                              : Color.fromARGB(255, 42, 66, 61)),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
