import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/app/di/injection_container.dart' as di;
import 'package:nutrivita_demo_v2/app/my_app.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   di.configureDependencies();
  await di.sl.allReady();
  //LocaleSettings.useDeviceLocale();
  LocaleSettings.setLocale(AppLocale.en);

  runApp(TranslationProvider(child: MyApp()));
}
