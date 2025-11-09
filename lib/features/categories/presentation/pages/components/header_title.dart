import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                t.welcome.introduce_test,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                t.prompt_food,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
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
    );
  }
}
