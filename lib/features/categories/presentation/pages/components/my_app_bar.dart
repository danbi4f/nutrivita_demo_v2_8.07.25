part of '../categories_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          rootScaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text(
        t.app_bar.app_title,
        style: AppTextStyles.heading(context, size: 40),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Image.asset('assets/USDA3.png', height: 40, width: 40),
        ),
      ],
    );
  }
}
