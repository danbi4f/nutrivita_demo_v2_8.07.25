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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: child,
      ),
    );
  }

  BoxDecoration boxDecorationGradient(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.2),
          theme.colorScheme.onPrimaryContainer.withOpacity(0.3),
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
    );
  }
}
