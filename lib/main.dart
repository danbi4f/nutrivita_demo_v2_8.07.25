import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/app/my_app.dart';
import 'package:nutrivita_demo_v2/app/di/injection_container.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //LocaleSettings.useDeviceLocale();
  LocaleSettings.setLocale(AppLocale.pl);

  final repositories = await buildRepositories();

  runApp(
    MultiRepositoryProvider(
      providers: repositories,
      child: TranslationProvider(child: MyApp()),
    ),
  );
}
