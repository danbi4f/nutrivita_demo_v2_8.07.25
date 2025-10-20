part of '../../../../shared/services/database_service/database_service.dart';

class FavoritesTableFdcId {
  static const String tableNameFavoritesFdcId = 'favorite_foods';
  static const String idColumnNameFavoritesFdcId = 'id';
  static const String fdcIdColumnNameFavoritesFdcId = 'fdcId';

  static String get createTableFavoritesFdcId => '''
    CREATE TABLE IF NOT EXISTS $tableNameFavoritesFdcId (
      $idColumnNameFavoritesFdcId INTEGER PRIMARY KEY AUTOINCREMENT,
      $fdcIdColumnNameFavoritesFdcId INTEGER UNIQUE
    )
  ''';
}

extension FavoritesFdcIdCrud on DatabaseService {
  // INSERT
  Future<int> insertFavoriteFdcId(int fdcId) async {
    final db = await database;
    return await db.insert(
      FavoritesTableFdcId.tableNameFavoritesFdcId,
      {FavoritesTableFdcId.fdcIdColumnNameFavoritesFdcId: fdcId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET ALL
  Future<List<int>> getFavoritesFdcIds() async {
    final db = await database;
    final maps = await db.query(FavoritesTableFdcId.tableNameFavoritesFdcId);
    print('📦 DB zawartość (favorites): ${maps.length}'); // 👈 DODAJ TO
    print('📦 DB zawartość (favorites): $maps'); // 👈 DODAJ TO
    return maps
        .map(
          (map) =>
              map[FavoritesTableFdcId.fdcIdColumnNameFavoritesFdcId] as int,
        )
        .toList();
  }

  // DELETE
  Future<int> deleteFavoriteFdcId(int fdcId) async {
    final db = await database;
    return await db.delete(
      FavoritesTableFdcId.tableNameFavoritesFdcId,
      where: '${FavoritesTableFdcId.fdcIdColumnNameFavoritesFdcId} = ?',
      whereArgs: [fdcId],
    );
  }

  // UPDATE - w tym przypadku update nie jest potrzebny, bo mamy tylko fdcId
  // jeśli chcesz, można użyć insert z ConflictAlgorithm.replace
}
