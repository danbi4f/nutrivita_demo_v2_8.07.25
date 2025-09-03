part of '../categories_page.dart';

class _ColumnAnimated extends StatelessWidget {
  const _ColumnAnimated({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final double scaleDown = 0.85;
    final double shiftRight = 150;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final scale = 1 - (controller.value * (1 - scaleDown));
        final shift = controller.value * shiftRight;
        final radius = controller.value * 10;

        return Transform(
          transform:
              Matrix4.identity()
                ..translate(shift)
                ..scale(scale),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: CustomContainer(
                isGradient: true,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    HeaderTitle(),
                    SizedBox(height: 20),
                    Expanded(child: CategoryGroupWidget()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
