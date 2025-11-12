import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/core/database/sql/database_service.dart';
import 'package:nutrivita_demo_v2/features/settings/widget/button_lang.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> resetDatabase(BuildContext context) async {
    final db = await DatabaseService.instance.database;
    await db.delete(FavoritesTableFdcId.tableNameFavoritesFdcId);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(t.alerts.confirm_reset_db)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.settings_page.app_bar)),
      body: CustomContainer(
        isGradient: true,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person, color: Colors.black, size: 30),
              title: Text(
                t.settings_page.profile,
                style: AppTextStyles.body(context, isBold: true),
              ),
              onTap: () {
                // Handle profile tap
              },
            ),
            ListTile(
              leading: Icon(
                Icons.restore_page_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                t.settings_page.db_restore_title,
                style: AppTextStyles.body(context, isBold: true),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(t.alerts.reset_db_window_title),
                      content: Text(
                        t.alerts.question_db_reset,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text(t.button.action.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            resetDatabase(context);
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text(t.button.action.confirm),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ButtonLang(),
          ],
        ),
      ),
    );
  }
}

