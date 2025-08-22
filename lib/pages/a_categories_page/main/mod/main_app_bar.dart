import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.toggleDrawer});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final void Function() toggleDrawer;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          toggleDrawer();
        },
        icon: Icon(Icons.menu, color: Colors.black),
      ),
      backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      centerTitle: true,
      title: Text('NutriVita', style: AppTextStyles.heading(context, size: 40)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Image.asset('assets/USDA3.png', height: 40, width: 40),
        ),
      ],
    );
  }
}
