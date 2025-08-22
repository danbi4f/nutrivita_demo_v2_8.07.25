import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/select_number/mod/select_number_item.dart';

class SelectNumber extends StatelessWidget {
  const SelectNumber({super.key, required this.category, required this.flag});

  final CategoryGroup category;
  final bool flag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        title: Text(
          category.categoryName,
          style: AppTextStyles.heading(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
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
        child: ListView.builder(
          itemCount: category.nutrientsGroup.length,
          itemBuilder: (context, index) {
            final nutrientByGroup = category.nutrientsGroup[index];

            return SelectNumberItem(
              flag: flag,
              nutrientByGroup: nutrientByGroup,
            );
          },
        ),
      ),
    );
  }
}
