import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill, // Range: 0 to 1
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              color: isDarkMode
                  ? Color.fromARGB(255, 48, 80, 82)
                  : Color.fromARGB(255, 48, 82, 81),
            ),
          ),
        ),
      ),
    );
  }
}
