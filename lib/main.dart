import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/my_app.dart';
import 'package:nutrivita_demo_v2/shared/services/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repositories = await buildRepositories();

  runApp(MultiRepositoryProvider(providers: repositories, child: MyApp()));
}
