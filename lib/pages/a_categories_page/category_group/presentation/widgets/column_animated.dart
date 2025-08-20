import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/category_group/presentation/widgets/category_group_widget/category_group_widget.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/category_group/presentation/widgets/header_title.dart';

class ColumnAnimated extends StatelessWidget {
  const ColumnAnimated({super.key, required this.controller});

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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),

                      Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    HeaderTitle(),
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
