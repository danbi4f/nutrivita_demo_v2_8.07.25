abstract class FavesRepository {
  Stream<List<int>> get favesStream;
  Future<List<int>> get favesFuture;
  Future<List<int>> getFaves();
  Future<void> addFave(int fdcId);
  Future<void> removeFave(int fdcId);
  Future<bool> isFave(int fdcId);
}