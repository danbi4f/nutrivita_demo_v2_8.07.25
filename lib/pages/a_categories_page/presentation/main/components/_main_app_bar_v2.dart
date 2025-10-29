part of '../categories_page_v2.dart';

class _MainAppBarV2 extends StatelessWidget implements PreferredSizeWidget {
  const _MainAppBarV2(
  );


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
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
