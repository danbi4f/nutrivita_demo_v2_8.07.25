import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/presentation/main/components/my_drawer.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/presentation/main/components/header_title_v2.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/presentation/mod/a_category_group_v2/category_group_widget_v2.dart';
part 'components/_main_app_bar_v2.dart';

class CategoriesPageV2 extends StatefulWidget {
  const CategoriesPageV2({super.key});

  @override
  State<CategoriesPageV2> createState() => _CategoriesPageV2State();
}

class _CategoriesPageV2State extends State<CategoriesPageV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: _MainAppBarV2(),
      drawer: const MyDrawer(),
      body: CustomContainer(
        isGradient: true,
        child: Column(
          children: [
            SizedBox(height: 20),
            HeaderTitleV2(),
            SizedBox(height: 60),
            Expanded(
              child: Builder(
                builder: (context) {
                  return CategoryGroupWidgetV2.withBloc();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
