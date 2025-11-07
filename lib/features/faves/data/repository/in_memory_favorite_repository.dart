import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/exceptions.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/faves/data/database/database_service.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class InMemoryFavesRepository extends FavesRepository {
  List<int> _faves = [];
  final DatabaseService _dbService;

  InMemoryFavesRepository({required DatabaseService dbService})
    : _dbService = dbService {
    print('${_now()} InMemoryFavesRepository CREATED');
  }

  Future<void> init() async {
    print('${_now()} init(): reading faves from DB...');
    final faves = await _dbService.getFavesFdcId();
    _faves = List.from(faves);
    print('${_now()} init(): loaded from DB -> $_faves');
    _favesController.add(List.unmodifiable(_faves));
    print('${_now()} init(): emitted initial snapshot to stream');
  }

  //===========================================================================

  final StreamController<List<int>> _favesController =
      StreamController<List<int>>.broadcast();

  //===========================================================================

  @override
  Stream<Either<Failure, List<int>>> get favesStream =>
      _favesController.stream.map((f) {
        print('${_now()} favesStream: emitting -> $f');
        return Right(f);
      });

  //===========================================================================

  @override
  Future<Either<Failure, List<int>>> get favesFuture async {
    print('${_now()} favesFuture getter called -> returning ${_faves}');
    return Right(List.unmodifiable(_faves));
  }

  //===========================================================================

  @override
  Future<Either<Failure, List<int>>> getFaves() async {
    print('${_now()} getFaves(): reading from DB...');
    try {
      final f = await _dbService.getFavesFdcId();
      _faves = List.unmodifiable(f);
      print('${_now()} getFaves(): backend returned -> $_faves');
      _favesController.add(_faves);
      print('${_now()} getFaves(): emitted snapshot -> $_faves');
      return Right(_faves);
    } on CacheException catch (e) {
      print('${_now()} getFaves(): CacheException -> $e');
      return Left(CacheFailure());
    } catch (e) {
      print('${_now()} getFaves(): unexpected error -> $e');
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  @override
  Future<Either<Failure, void>> addFave(int fdcId) async {
    print('${_now()} addFave($fdcId) called; current -> $_faves');
    try {
      // create new list copy (immutable pattern)
      _faves = List.from(_faves)..add(fdcId);
      print('${_now()} addFave: local updated -> $_faves (before DB)');
      _favesController.add(List.unmodifiable(_faves));
      print('${_now()} addFave: emitted snapshot -> $_faves (optimistic)');
      await _dbService.addFaveFdcId(fdcId);
      print('${_now()} addFave: DB updated for $fdcId');
      return const Right(null);
    } on CacheException catch (e) {
      print('${_now()} addFave: CacheException -> $e');
      return Left(CacheFailure());
    } catch (e) {
      print('${_now()} addFave: unexpected -> $e');
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  @override
  Future<Either<Failure, void>> removeFave(int fdcId) async {
    print('${_now()} removeFave($fdcId) called; current -> $_faves');
    try {
      // remove in immutable style
      _faves = List.from(_faves)..remove(fdcId);
      print('${_now()} removeFave: local updated -> $_faves (before DB)');
      _favesController.add(List.unmodifiable(_faves));
      print('${_now()} removeFave: emitted snapshot -> $_faves (optimistic)');
      await _dbService.removeFaveFdcId(fdcId);
      print('${_now()} removeFave: DB removed $fdcId');
      return const Right(null);
    } on CacheException catch (e) {
      print('${_now()} removeFave: CacheException -> $e');
      return Left(CacheFailure());
    } catch (e) {
      print('${_now()} removeFave: unexpected -> $e');
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  @override
  Future<Either<Failure, bool>> isFave(int fdcId) async {
    print('${_now()} isFave($fdcId) called; current -> $_faves');
    try {
      final contains = _faves.contains(fdcId);
      print('${_now()} isFave: result -> $contains');
      return Right(contains);
    } on CacheException catch (e) {
      print('${_now()} isFave: CacheException -> $e');
      return Left(CacheFailure());
    } catch (e) {
      print('${_now()} isFave: unexpected -> $e');
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  void dispose() {
    print('${_now()} dispose() called');
    _favesController.close();
  }

  // helper
  String _now() => DateTime.now().toIso8601String();
}

