import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/number_group/number_group_item.dart';
import 'dart:math';

class NumberGroup extends StatelessWidget {
  final CategoryNutrient item;

  const NumberGroup({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    const int itemsPerPage = 6; // how many elements on one page
    const int columns = 2; // number of columns in the grid
    const double itemHeight = 160.0; // element height

    // we divide the list into pages
    final pages = <List<dynamic>>[];
    for (var i = 0; i < item.nutrients.length; i += itemsPerPage) {
      pages.add(item.nutrients.sublist(i, min(i + itemsPerPage, item.nutrients.length)));
    }

    final pageController = PageController(viewportFraction: 0.92);

    // We calculate the height of the entire grid on the page
    final int rows = (itemsPerPage / columns).ceil();
    final double gridHeight = rows * itemHeight + (rows - 1) * 12; // + spacing

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          item.category,
          style: AppTextStyles.heading(context, size: 40),
        ),
        centerTitle: true,
      ),
      body: CustomContainer(
        isGradient: true,
        child: SizedBox(
          child: PageView.builder(
            controller: pageController,
            padEnds: false,
            itemCount: pages.length,
            itemBuilder: (context, pageIndex) {
              final pageItems = pages[pageIndex];

              return Padding(
                padding: EdgeInsets.only(
                  left: pageIndex == 0 ? 16 : 8,
                  right: 8,
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: pageItems.length,
                  itemBuilder: (context, index) {
                    final nutrientByGroup = pageItems[index];
                    return SizedBox(
                      height: itemHeight,
                      child: NumberGroupItem(
                        nutrientByGroup: nutrientByGroup,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
