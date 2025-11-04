import 'dart:async';

import 'package:nutrivita_demo_v2/features/faves/data/database/database_service.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class InMemoryFavesRepository extends FavesRepository {
  List<int> _faves = [];
  final DatabaseService _dbService;

  InMemoryFavesRepository({required DatabaseService dbService})
    : _dbService = dbService;

  Future<void> init() async {
    final faves = await _dbService.getFavesFdcId();
    _faves.addAll(faves);
    _favesController.add(List.unmodifiable(_faves));
  }

  final StreamController<List<int>> _favesController =
      StreamController<List<int>>.broadcast();

  @override
  Stream<List<int>> get favesStream => _favesController.stream;
  @override
  Future<List<int>> get favesFuture async => List.unmodifiable(_faves);

  @override
  Future<List<int>> getFaves() async {
    _faves = await _dbService.getFavesFdcId();
    return _faves;
  }

  @override
  Future<void> addFave(int fdcId) async {
    _faves.add(fdcId);
    _favesController.add(List.unmodifiable(_faves));
    await _dbService.addFaveFdcId(fdcId);
  }

  @override
  Future<void> removeFave(int fdcId) async {
    if (!_faves.contains(fdcId)) return;
    _faves.remove(fdcId);
    _favesController.add(List.unmodifiable(_faves));
    await _dbService.removeFaveFdcId(fdcId);
  }

  @override
  Future<bool> isFave(int fdcId) async {
    return _faves.contains(fdcId);
  }

  void dispose() {
    _favesController.close();
  }
}
