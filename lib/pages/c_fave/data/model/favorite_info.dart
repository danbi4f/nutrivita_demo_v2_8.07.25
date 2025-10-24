import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/complet_foods.dart';

class FavoriteInfo {
  Map<int, CompleteFood> items;

  FavoriteInfo({required this.items});

  FavoriteInfo copyWith({Map<int, CompleteFood>? items}) {
    return FavoriteInfo(
      items: items ?? this.items,
    );
  }
}