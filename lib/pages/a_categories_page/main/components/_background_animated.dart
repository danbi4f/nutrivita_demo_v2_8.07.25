part of '../categories_page.dart';

class _BackgroundAnimated extends StatelessWidget {
  const _BackgroundAnimated({
    required this.controller,
    required this.toggleDrawer,
  });

  final AnimationController controller;
  final void Function() toggleDrawer;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return GestureDetector(
          onTap: toggleDrawer,
          child: Container(
            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(
              0.4 * controller.value,
            ),
          ),
        );
      },
    );
  }
}
