import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/data/model/search_engine_model.dart';

class SearchEngineItem extends StatelessWidget {
  const SearchEngineItem({super.key, required this.item});

  final SearchEngineModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // dark
          BoxShadow(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            offset: const Offset(7, 7),
            blurRadius: 25,
            spreadRadius: 2,
          ),

          // light
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            offset: const Offset(-4, -4),
            blurRadius: 20,
            spreadRadius: 0,
          ),

          //
        ],
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              item.descriptionPL,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
            ),
            SizedBox(height: 10),
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
