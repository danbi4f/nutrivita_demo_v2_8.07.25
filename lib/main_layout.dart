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
          backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          centerTitle: true,
          title: Text(
            'NutriVita',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Theme.of(context).colorScheme.surfaceBright,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset('assets/USDA3.png', height: 40, width: 40),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [DrawerHeader(child: Text('Nutrivita Demo'))],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        body: Container(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Column(
            children: [
              SizedBox(height: 10),
              HeaderTitle(),

              Expanded(child: CategoryGroupWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
