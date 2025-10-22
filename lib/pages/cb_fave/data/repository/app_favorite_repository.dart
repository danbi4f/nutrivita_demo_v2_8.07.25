import 'package:nutrivita_demo_v2/shared/services/database_service/database_service.dart';

class AppFavoriteRepository {
  final DatabaseService dbService;
  final List<int> _faves = [];

  AppFavoriteRepository({required this.dbService});

  Future<int> addFavorite(int fdcId) async {
    return await dbService.addFaveFdcId(fdcId);
  }

  Future<List<int>> getAllFavorites() async {
    return await dbService.getFavesFdcId();
  }

  Future<int> removeFavorite(int fdcId) async {
    return await dbService.removeFaveFdcId(fdcId);
  }

  Future<List<int>> isFave() async {
    final faves = await getAllFavorites();
    _faves.clear();
    _faves.addAll(faves);
    return _faves;
  }
}
