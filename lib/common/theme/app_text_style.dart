import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle title(
    BuildContext context, {
    double size = 28,
    bool? isBold, // null = użyj domyślnego ustawienia
  }) {
    return TextStyle(
      fontWeight: (isBold ?? true) ? FontWeight.bold : FontWeight.normal,
      fontSize: size,
      color: AppColors.textSurfaceBright(context),
    );
  }

  // Duży nagłówek, np. tytuły ekranów
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

  // Średni nagłówek, np. sekcje
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

  // Normalny tekst, np. paragrafy
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

  // Mniejszy tekst, np. opisy, dopiski
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

  // Mały, delikatny tekst, np. podpowiedzi, daty
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
  // Centralny kolor tekstu
  static Color textSurfaceBright(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceBright;
  }
}
