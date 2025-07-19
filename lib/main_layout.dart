import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/category_group_widget.dart';
import 'package:nutrivita_demo_v2/widget/header_title.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainPayoutState();
}

class _MainPayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          title: Text(
            'NutriVita',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset('assets/USDA.png', height: 40, width: 40),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [DrawerHeader(child: Text('Nutrivita Demo'))],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        body: Column(
          children: [HeaderTitle(), Expanded(child: CategoryGroupWidget())],
        ),
      ),
    );
  }
}
