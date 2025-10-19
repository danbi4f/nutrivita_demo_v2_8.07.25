import 'dart:async';
import 'app_favorite_repository.dart';

class InMemoryFavoriteRepository {
  final AppFavoriteRepository appFavoriteRepository;

  final Set<int> _favorites = {};
  final StreamController<Set<int>> _favoritesController =
      StreamController<Set<int>>.broadcast();

  Stream<Set<int>> get favoritesStream => _favoritesController.stream;

  InMemoryFavoriteRepository({required this.appFavoriteRepository});

  Future<void> init() async {
    final allFavorites = await appFavoriteRepository.getAllFavorites();
    _favorites.addAll(allFavorites);
    _favoritesController.add(Set.from(_favorites));
  }

  Future<void> addFavorite(int fdcId) async {
    _favorites.add(fdcId);
    _favoritesController.add(Set.from(_favorites));
    await appFavoriteRepository.addFavorite(fdcId);
  }

  Future<void> removeFavorite(int fdcId) async {
    _favorites.remove(fdcId);
    _favoritesController.add(Set.from(_favorites));
    await appFavoriteRepository.removeFavorite(fdcId);
  }

  bool isFavorite(int fdcId) => _favorites.contains(fdcId);

  void dispose() {
    _favoritesController.close();
  }
}
