import 'package:nutrivita_demo_v2/shared/services/database_service/database_service.dart';

class AppFavoriteRepository {
  final DatabaseService dbService;

  AppFavoriteRepository({required this.dbService});

  Future<int> addFavorite(int fdcId) async {
    return await dbService.insertFavoriteFdcId(fdcId);
  }

  Future<List<int>> getAllFavorites() async {
    return await dbService.getFavoritesFdcIds();
  }

  Future<int> removeFavorite(int fdcId) async {
    return await dbService.deleteFavoriteFdcId(fdcId);
  }
}
