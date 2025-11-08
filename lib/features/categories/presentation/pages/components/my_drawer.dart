import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/settings/setting_page.dart';
import 'package:nutrivita_demo_v2/features/settings/widget/button_lang.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 260,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "DanBi",
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
              text: "Home",
              onTap: () => Navigator.pop(context),
            ),
            _drawerTile(
              icon: Icons.favorite_border,
              text: "Fave",
              onTap: () => Navigator.pop(context),
            ),

            const Divider(),

            // ⚙️ System / settings section
            _drawerTile(
              icon: Icons.settings_outlined,
              text: "Settings",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingPage()),
                );
              },
            ),
            _drawerTile(
              icon: Icons.info_outline,
              text: "About the app",
              onTap: () {},
            ),
            ButtonLang(),

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
      leading: Icon(icon, color: Colors.green.shade700, size: 28), // larger icon
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
