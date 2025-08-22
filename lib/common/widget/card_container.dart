import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const CardContainer({super.key, required this.child, this.borderRadius = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            offset: const Offset(7, 7),
            blurRadius: 25,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            offset: const Offset(-4, -4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: child,
      ),
    );
  }
}
