import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            offset: const Offset(4, 4),
            blurRadius: 30,
            spreadRadius: 1,
            inset: true,
          ),
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255),
            offset: const Offset(-4, -4),
            blurRadius: 30,
            spreadRadius: -5,
            inset: true,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome DanBi 👋',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'What would you like to eat?  ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
            ],
          ),
          const SizedBox(width: 18.0),
          ClipOval(
            child: Image.network(
              'https://cdn.pixabay.com/photo/2017/02/25/22/04/minion-2098869_1280.png',
              width: 100,
              height: 100,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
