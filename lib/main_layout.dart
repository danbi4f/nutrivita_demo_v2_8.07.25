import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/my_grid_view.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/widget/header_title.dart';

class MainPayout extends StatefulWidget {
  const MainPayout({super.key});

  @override
  State<MainPayout> createState() => _MainPayoutState();
}

class _MainPayoutState extends State<MainPayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          centerTitle: true,
          title: Text(
            'NutriVita',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
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
        body: BlocListener<NumberBloc, NumbersState>(
          listener: (context, state) {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              HeaderTitle(),
              const SizedBox(height: 30.0),
              Expanded(child: MyGridView()),
            ],
          ),
        ),
      ),
    );
  }
}
