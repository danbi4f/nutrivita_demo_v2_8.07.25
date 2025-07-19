import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    super.key,
    required this.nameButton,
    required this.onTap,
    required this.selectedIndex,
  });

  final String nameButton;
  final VoidCallback onTap;
  final bool selectedIndex;

  @override
  Widget build(BuildContext context) {
    final box = [
      BoxShadow(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        offset: const Offset(4, 4),
        blurRadius: 20,
        spreadRadius: 5,
      ),
      BoxShadow(
        color: Colors.white24,
        offset: const Offset(-4, -4),
        blurRadius: 20,
        spreadRadius: -5,
      ),
    ];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          boxShadow: selectedIndex ? box : [],
        ),
        child: Center(
          child: Text(
            nameButton,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
