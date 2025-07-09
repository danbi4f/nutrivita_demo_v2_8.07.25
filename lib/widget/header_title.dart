import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'Welcome DanBi 👋',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'What would you like to eat?  ',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(width: 18.0),
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            'https://cdn.pixabay.com/photo/2013/07/12/19/14/angry-154378_1280.png',
          ),
        ),
      ],
    );
  }
}
