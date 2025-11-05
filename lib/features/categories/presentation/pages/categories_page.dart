import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/pages/components/my_drawer.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/pages/components/header_title.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/category_group/category_group_widget.dart';
part 'components/_main_app_bar.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageV2State();
}

class _CategoriesPageV2State extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: _MainAppBar(),
      drawer: const MyDrawer(),
      body: CustomContainer(
        isGradient: true,
        child: Column(
          children: [
            SizedBox(height: 20),
            HeaderTitle(),
            SizedBox(height: 60),
            Expanded(
              child: Builder(
                builder: (context) {
                  return CategoryGroupWidget.withBloc();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
