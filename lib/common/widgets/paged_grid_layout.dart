import 'package:flutter/material.dart';

class PagedGridLayout<T> extends StatelessWidget {
  final List<T> items;
  final int itemsPerPage;
  final int columns;
  final double viewportFraction;
  final Widget Function(T item) itemBuilder;

  final double? dynamicAvailableHeight;

  const PagedGridLayout({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.itemsPerPage = 6,
    this.columns = 2,
    this.viewportFraction = 0.92,
    this.dynamicAvailableHeight,
  });
  //!======================================================================================
  //🏗️🏗️🏗️🏗️🏗️
  @override
  Widget build(BuildContext context) {
    final pages = _splitToPages(items, itemsPerPage);

    //TODO=================================
    final pageController = PageController(
      //initialPage: 1,
      viewportFraction: viewportFraction,
    );
    //!======================================================================================
    //🧩🧩🧩🧩🧩
    return LayoutBuilder(
      builder: (context, constraints) {
        // here you control the altitude
        final usableHeight = dynamicAvailableHeight ?? constraints.maxHeight;

        final rows = (itemsPerPage / columns).ceil();
        // you can make spacing parameterized in the future
        const spacing = 12.0;
        // dynamic item height
        final itemHeight = (usableHeight - ((rows - 1) * spacing)) / rows;
        //!======================================================================================
        // 🪟🪟🪟🪟🪟
        return PageView.builder(
          allowImplicitScrolling: true,
          controller: pageController,
          padEnds: false,
          itemCount: pages.length,
          itemBuilder: (context, pageIndex) {
            final pageItems = pages[pageIndex];

            return Padding(
              padding: EdgeInsets.only(left: pageIndex == 0 ? 16 : 8, right: 8),
              //!======================================================================================
              //🏐🏐🏐🏐🏐
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  // Everyone can calculate the width themselves using constraints
                  // We base the height on dynamic height
                  childAspectRatio:
                      1 / (itemHeight / (constraints.maxWidth / columns)),
                ),
                itemCount: pageItems.length,
                itemBuilder: (context, index) {
                  //!======================================================================================
                  //👶👶👶👶👶
                  return SizedBox(
                    height: itemHeight,
                    child: itemBuilder(pageItems[index]),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  List<List<T>> _splitToPages(List<T> items, int perPage) {
    final pages = <List<T>>[];
    for (int i = 0; i < items.length; i += perPage) {
      pages.add(items.sublist(i, (i + perPage).clamp(0, items.length)));
    }
    return pages;
  }
}
