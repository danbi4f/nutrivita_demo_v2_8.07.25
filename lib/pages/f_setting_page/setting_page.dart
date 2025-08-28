import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/shared/database_service/database_service.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> resetDatabase(BuildContext context) async {
    final db = await DatabaseService.instance.database;
    await db.delete(MealsTable.tableNameMeals);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Database has been reset')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings Page')),
      body: CustomContainer(
        isGradient: true,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person, color: Colors.black, size: 30),
              title: Text(
                'Profile',
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
                'DataBase Restore',
                style: AppTextStyles.body(context, isBold: true),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Reset Database'),
                      content: Text(
                        'Are you sure you want to reset the database?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            resetDatabase(context);
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
