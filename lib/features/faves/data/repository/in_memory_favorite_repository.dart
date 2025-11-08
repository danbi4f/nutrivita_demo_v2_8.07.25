import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/exceptions.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/faves/data/datasources/faves_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class InMemoryFavesRepository extends FavesRepository {
  List<int> _faves = [];
  final favesLocalDataSource localDataSource;

  InMemoryFavesRepository({required this.localDataSource}) {
    print('${_now()} InMemoryFavesRepository CREATED');
  }

  Future<void> init() async {
    print('${_now()} init(): reading faves from DataSource...');
    final faves = await localDataSource.getFaves();
    _faves = List.from(faves);
    print('${_now()} init(): loaded -> $_faves');
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
    print('${_now()} favesFuture getter called -> returning $_faves');
    return Right(List.unmodifiable(_faves));
  }

  //===========================================================================

  @override
  Future<Either<Failure, List<int>>> getFaves() async {
    print('${_now()} getFaves(): reading from DataSource...');
    try {
      final f = await localDataSource.getFaves();
      _faves = List.unmodifiable(f);
      print('${_now()} getFaves(): returned -> $_faves');
      _favesController.add(_faves);
      return Right(_faves);
    } on CacheException catch (_) {
      return Left(CacheFailure());
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  @override
  Future<Either<Failure, void>> addFave(int fdcId) async {
    print('${_now()} addFave($fdcId) called; current -> $_faves');
    try {
      _faves = List.from(_faves)..add(fdcId);
      _favesController.add(List.unmodifiable(_faves));
      await localDataSource.addFave(fdcId);
      return const Right(null);
    } on CacheException catch (_) {
      return Left(CacheFailure());
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  @override
  Future<Either<Failure, void>> removeFave(int fdcId) async {
    print('${_now()} removeFave($fdcId) called; current -> $_faves');
    try {
      _faves = List.from(_faves)..remove(fdcId);
      _favesController.add(List.unmodifiable(_faves));
      await localDataSource.removeFave(fdcId);
      return const Right(null);
    } on CacheException catch (_) {
      return Left(CacheFailure());
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  @override
  Future<Either<Failure, bool>> isFave(int fdcId) async {
    print('${_now()} isFave($fdcId) called; current -> $_faves');
    try {
      final contains = _faves.contains(fdcId);
      return Right(contains);
    } on CacheException catch (_) {
      return Left(CacheFailure());
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  //===========================================================================

  void dispose() {
    print('${_now()} dispose() called');
    _favesController.close();
  }

  String _now() => DateTime.now().toIso8601String();
}
