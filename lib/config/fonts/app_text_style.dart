import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle title(
    BuildContext context, {
    double size = 28,
    bool? isBold, // null = use default setting
  }) {
    return TextStyle(
      fontWeight: (isBold ?? true) ? FontWeight.bold : FontWeight.normal,
      fontSize: size,
      color: AppColors.textSurfaceBright(context),
    );
  }

// Large header, e.g. screen titles
  static TextStyle heading(
    BuildContext context, {
    double size = 24,
    bool? isBold,
  }) {
    return TextStyle(
      fontWeight: (isBold ?? true) ? FontWeight.bold : FontWeight.normal,
      fontSize: size,
      color: AppColors.textSurfaceBright(context),
    );
  }

  // Medium heading, e.g. sections
  static TextStyle subheading(
    BuildContext context, {
    double size = 20,
    bool? isBold,
  }) {
    return TextStyle(
      fontWeight: (isBold ?? true) ? FontWeight.w600 : FontWeight.normal,
      fontSize: size,
      color: AppColors.textSurfaceBright(context),
    );
  }

  // Normal text, e.g. paragraphs
  static TextStyle body(
    BuildContext context, {
    double size = 16,
    bool? isBold,
  }) {
    return TextStyle(
      fontWeight: (isBold ?? false) ? FontWeight.bold : FontWeight.normal,
      fontSize: size,
      color: AppColors.textSurfaceBright(context),
    );
  }

  // Smaller text, e.g. descriptions, notes
  static TextStyle caption(
    BuildContext context, {
    double size = 12,
    bool? isBold,
  }) {
    return TextStyle(
      fontWeight: (isBold ?? false) ? FontWeight.bold : FontWeight.normal,
      fontSize: size,
      color: AppColors.textSurfaceBright(context),
    );
  }

// Small, delicate text, e.g. tooltips, dates
  static TextStyle hint(
    BuildContext context, {
    double size = 10,
    bool? isBold,
  }) {
    return TextStyle(
      fontWeight: (isBold ?? false) ? FontWeight.bold : FontWeight.w300,
      fontSize: size,
      color: AppColors.textSurfaceBright(context),
    );
  }
}

class AppColors {
  // Center text color
  static Color textSurfaceBright(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceBright;
  }
}
