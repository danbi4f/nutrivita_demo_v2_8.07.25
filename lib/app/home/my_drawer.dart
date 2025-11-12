import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/settings/setting_page.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Drawer(
      width: 260,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan()),
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  t.welcome.user_name_test,
                  style: TextStyle(
                    fontSize: 28, // larger title
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // 🔹 Main navigation items
            _drawerTile(
              icon: Icons.home_outlined,
              text: t.drawer.home,
              onTap: () => Navigator.pop(context),
            ),
            _drawerTile(
              icon: Icons.favorite_border,
              text: t.drawer.fave,
              onTap: () => Navigator.pop(context),
            ),

            const Divider(),

            // ⚙️ System / settings section
            _drawerTile(
              icon: Icons.settings_outlined,
              text: t.drawer.settings,
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SettingPage()));
              },
            ),
            _drawerTile(
              icon: Icons.info_outline,
              text: t.drawer.about,
              onTap: () {},
            ),
            _drawerTile(
              icon: Icons.language,
              text: t.drawer.language,
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text(t.drawer.select_lang),
                        content: StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButton<AppLocale>(
                              // dropdownColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              value: LocaleSettings.currentLocale,
                              items:
                                  AppLocale.values.map((locale) {
                                    return DropdownMenuItem<AppLocale>(
                                      value: locale,
                                      child: Text(
                                        locale.languageTag,
                                      ), // pl / en
                                    );
                                  }).toList(),
                              onChanged: (locale) {
                                if (locale != null) {
                                  setState(() {
                                    LocaleSettings.setLocale(locale);
                                  });
                                }
                              },
                            );
                          },
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
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text(t.button.action.confirm),
                          ),
                        ],
                      ),
                );
              },
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  // Helper widget for consistent size and spacing
  Widget _drawerTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.green.shade700,
        size: 28,
      ), // larger icon
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 18, // larger font
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      minVerticalPadding: 14, // more vertical space between items
      onTap: onTap,
    );
  }
}
