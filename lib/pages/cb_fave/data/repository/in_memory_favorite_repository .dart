import 'dart:async';

import 'package:nutrivita_demo_v2/shared/services/database_service/database_service.dart';

class InMemoryFaveRepository {
  List<int> _faves = [];
  final DatabaseService _dbService;

  InMemoryFaveRepository({required DatabaseService dbService})
    : _dbService = dbService;

  Future<void> init() async {
    final faves = await _dbService.getFavesFdcId();
    _faves.addAll(faves);
    _favesController.add(List.unmodifiable(_faves));
  }

  final StreamController<List<int>> _favesController =
      StreamController<List<int>>.broadcast();

  Stream<List<int>> get favesStream => _favesController.stream;

  Future<List<int>> get favesFuture async => List.unmodifiable(_faves);
  

  Future<List<int>> getFaves() async {
    _faves = await _dbService.getFavesFdcId();
    return _faves;
  }

  Future<void> addFave(int fdcId) async {
    _faves.add(fdcId);
    _favesController.add(List.unmodifiable(_faves));
    await _dbService.addFaveFdcId(fdcId);
  }

  Future<void> removeFave(int fdcId) async {
    if(!_faves.contains(fdcId)) return;
    _faves.remove(fdcId);
    _favesController.add(List.unmodifiable(_faves));
    await _dbService.removeFaveFdcId(fdcId);
  }
  Future<bool> isFave(int fdcId) async {
    return _faves.contains(fdcId);
  }

  void dispose() {
    _favesController.close();
  }

}
