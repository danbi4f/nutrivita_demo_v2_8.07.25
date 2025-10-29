import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double? margin;
  final bool isGradient;

  const CustomContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.isGradient = false,

    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: isGradient ? const EdgeInsets.all(0) : const EdgeInsets.all(10.0),
      decoration:
          isGradient
              ? boxDecorationGradient(context)
              : boxDecorationCard(context),
      child: child,
    );
  }

  BoxDecoration boxDecorationGradient(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.white,
          //theme.colorScheme.onPrimaryContainer.withOpacity(0.3),
          //Colors.green
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.1),
      ),
      boxShadow: [
        BoxShadow(color: theme.colorScheme.onSurfaceVariant, blurRadius: 20),
      ],
    );
  }

BoxDecoration boxDecorationCard(BuildContext context) {
  return BoxDecoration(
    color: const Color(0xFFD9E5C4),
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      // cień dolny (ciemniejszy, bardzo rozmyty)
      BoxShadow(
        color: const Color(0xFFB7CE9E),
        offset: const Offset(6, 6),
        blurRadius: 12,
        spreadRadius: 1,
      ),
      // cień górny (jaśniejszy, miękki highlight)
      BoxShadow(
        color: Colors.white.withOpacity(0.8),
        offset: const Offset(-4, -4),
        blurRadius: 10,
        spreadRadius: 0,
      ),
    ],
  );
}
}
