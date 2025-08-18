import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyCustomButton2 extends StatelessWidget {
  const MyCustomButton2({
    super.key,
    required this.foodsSelected,
    required this.onToggle,
  });

  final bool foodsSelected;
  final void Function(bool value) onToggle;

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          offset: const Offset(-8, -8),
          color: const Color.fromARGB(157, 78, 77, 77),
          blurRadius: 30,
          inset: true,
        ),
        BoxShadow(
          offset: const Offset(4, 4),
          color: const Color.fromARGB(255, 19, 5, 4),
          blurRadius: 10,
          inset: true,
        ),
      ],
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      borderRadius:
          foodsSelected
              ? BorderRadius.only(bottomRight: Radius.circular(40))
              : BorderRadius.only(bottomLeft: Radius.circular(40)),
    );

    var widthApp = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints(maxHeight: 50, maxWidth: widthApp),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (foodsSelected) onToggle(false);
              },
              child: Container(
                decoration: foodsSelected ? boxDecoration : null,
                height: 50,
                width: widthApp / 2,
                child: Center(
                  child: Text(
                    'Survey Foods',
                    style: TextStyle(
                      color:
                          !foodsSelected
                              ? Theme.of(context).colorScheme.surfaceBright
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!foodsSelected) onToggle(true);
              },
              child: Container(
                decoration: !foodsSelected ? boxDecoration : null,
                height: 50,
                width: widthApp / 2,
                child: Center(
                  child: Text(
                    'Foundation Foods',
                    style: TextStyle(
                      color:
                          foodsSelected
                              ? Theme.of(context).colorScheme.surfaceBright
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
