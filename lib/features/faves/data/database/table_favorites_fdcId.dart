part of 'database_service.dart';

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
  Future<int> addFaveFdcId(int fdcId) async {
    final db = await database;
    return await db.insert(
      FavoritesTableFdcId.tableNameFavoritesFdcId,
      {FavoritesTableFdcId.fdcIdColumnNameFavoritesFdcId: fdcId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET ALL
  Future<List<int>> getFavesFdcId() async {
    final db = await database;
    final maps = await db.query(FavoritesTableFdcId.tableNameFavoritesFdcId);
    print('📦 DB zawartość (favorites): ${maps.length}'); 
    print('📦 DB zawartość (favorites): $maps'); 
    return maps
        .map(
          (map) =>
              map[FavoritesTableFdcId.fdcIdColumnNameFavoritesFdcId] as int,
        )
        .toList();
  }

  // DELETE
  Future<int> removeFaveFdcId(int fdcId) async {
    final db = await database;
    return await db.delete(
      FavoritesTableFdcId.tableNameFavoritesFdcId,
      where: '${FavoritesTableFdcId.fdcIdColumnNameFavoritesFdcId} = ?',
      whereArgs: [fdcId],
    );
  }

}
