import 'package:nutrivita_demo_v2/core/error/exceptions.dart';
import 'package:nutrivita_demo_v2/core/database/sql/database_service.dart';

abstract class FavesLocalDataSource {
  Future<List<int>> getFaves();
  Future<void> addFave(int fdcId);
  Future<void> removeFave(int fdcId);
}



class FavesLocalDataSourceImpl implements FavesLocalDataSource {
  final DatabaseService dbService;

  FavesLocalDataSourceImpl({required this.dbService});

  @override
  Future<List<int>> getFaves() async {
    try {
      return await dbService.getFavesFdcId();
    } catch(_) {
      throw CacheException();
    }
  }

  @override
  Future<void> addFave(int fdcId) async {
    try {
      await dbService.addFaveFdcId(fdcId);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> removeFave(int fdcId) async {
    try {
      await dbService.removeFaveFdcId(fdcId);
    } catch (_) {
      throw CacheException();
    }
  }

}
