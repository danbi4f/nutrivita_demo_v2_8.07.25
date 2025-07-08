import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, this.onTap, required this.categoryName});

  final void Function()? onTap;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      print('Container został tapnięty!');
    }

    return GestureDetector(
      onTap: onTap ?? _onTap,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              // dark
              BoxShadow(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                offset: const Offset(4, 4),
                blurRadius: 20,
                spreadRadius: 5,
              ),

              // light
              BoxShadow(
                color: Colors.white24,
                offset: const Offset(-4, -4),
                blurRadius: 20,
                spreadRadius: -5,
              ),

              //
            ],
          ),
          child: Text(categoryName, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
