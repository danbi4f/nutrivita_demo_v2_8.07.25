import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/data/model/search_engine_model.dart';

class SearchEngineItem extends StatelessWidget {
  const SearchEngineItem({super.key, required this.item});

  final SearchEngineModel item;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              item.descriptionPL,
              textAlign: TextAlign.center,
              style: AppTextStyles.subheading(context),
            ),
            SizedBox(height: 10),
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(context),
            ),
          ],
        ),
      ),
    );
  }
}
