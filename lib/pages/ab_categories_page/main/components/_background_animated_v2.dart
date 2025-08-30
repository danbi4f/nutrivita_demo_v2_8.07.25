part of '../categories_page_v2.dart';

class _BackgroundAnimatedV2 extends StatelessWidget {
  const _BackgroundAnimatedV2({
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
