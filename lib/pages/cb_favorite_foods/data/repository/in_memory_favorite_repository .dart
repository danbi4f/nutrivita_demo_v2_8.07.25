import 'dart:async';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/data/model/favorite_info.dart';

// import 'app_favorite_repository.dart';

class InMemoryFavoriteRepository {
  final FavoriteInfo _favoriteInfo = FavoriteInfo(items: {});

  FavoriteInfo get favoriteInfo => _favoriteInfo;

  final StreamController<FavoriteInfo> _favoritesController =
      StreamController<FavoriteInfo>.broadcast();

  Stream<FavoriteInfo> get favoritesStream => _favoritesController.stream;

  Future<FavoriteInfo> get favoritesFuture async =>
      _favoriteInfo.copyWith(items: Map.unmodifiable(_favoriteInfo.items));

  Future<void> addFavorite(CompleteFood item) async {
    final favoriteItem = CompleteFood(
      fdcId: item.fdcId,
      description: item.description,
      descriptionPL: item.descriptionPL,
      foodClass: item.foodClass,
      nutrients: item.nutrients,
    );
    _favoriteInfo.items[item.fdcId] = favoriteItem;

        final favoriteInfo = _favoriteInfo.copyWith(
      items: Map.unmodifiable(_favoriteInfo.items),
    );

    _favoritesController.add(favoriteInfo);

  }

  Future<void> removeFavorite(CompleteFood item) async {

  }
}
