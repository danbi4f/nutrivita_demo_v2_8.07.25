import 'package:flutter/material.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListView(children: children),
      ),
    );
  }
}
