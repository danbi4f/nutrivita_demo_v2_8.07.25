import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class ButtonLang extends StatelessWidget {
  const ButtonLang({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.language, color: Colors.black, size: 30),
      title: Text(
        'Language', // później podmienimy na t.settings.language
        style: AppTextStyles.body(context, isBold: true),
      ),
      trailing: DropdownButton<AppLocale>(
        dropdownColor: Colors.white,
        style: TextStyle(color: Colors.black),
        value: LocaleSettings.currentLocale,
        items:
            AppLocale.values.map((locale) {
              return DropdownMenuItem<AppLocale>(
                value: locale,
                child: Text(locale.languageTag), // pl / en
              );
            }).toList(),
        onChanged: (locale) {
          if (locale != null) {
            LocaleSettings.setLocale(locale);
          }
        },
      ),
    );
  }
}
