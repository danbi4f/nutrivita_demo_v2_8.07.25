part of '../categories_page.dart'; // wskazuje, że to część głównego pliku

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MainAppBar({required this.toggleDrawer});

  final void Function() toggleDrawer;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: toggleDrawer,
        icon: const Icon(Icons.menu, color: Colors.black),
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
