import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/widgets/fave_item.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:collection/collection.dart';

class FaveSuccessWidget extends StatelessWidget {
  const FaveSuccessWidget({
    super.key,
    required this.listInt,
    required this.foods,
    this.itemsPerPage = 6,
  });

  final List<int> listInt;
  final List<Food> foods;
  final int itemsPerPage;

  @override
  Widget build(BuildContext context) {
    // we divide the list into pages
    final pages = <List<int>>[];
    for (var i = 0; i < listInt.length; i += itemsPerPage) {
      pages.add(listInt.sublist(
        i,
        (i + itemsPerPage).clamp(0, listInt.length),
      ));
    }

    final pageController = PageController(
      viewportFraction: 0.91, // X% width for the page → X% visible on the right
    );

    return SafeArea(
      bottom: true,
      child: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        padEnds: false,
        pageSnapping: true,
        itemBuilder: (context, pageIndex) {
          final pageItems = pages[pageIndex];

          return Padding(
            padding: EdgeInsets.only(
              left: pageIndex == 0 ? 16 : 8, // first view at the left edge
              right: 8,                        // space between pages
            ),
            child: Column(
              children: pageItems.map((fdcId) {
                final food = foods.firstWhereOrNull((food) => food.fdcId == fdcId);
                if (food == null) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text('Food item not found'),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: FaveItem(fdcId: fdcId, food: food),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
