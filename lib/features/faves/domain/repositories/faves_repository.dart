import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';

abstract class FavesRepository {
  Stream<Either<Failure, List<int>>> get favesStream;
  Future<Either<Failure, List<int>>> get favesFuture;
  Future<Either<Failure, List<int>>> getFaves();
  Future<Either<Failure, void>> addFave(int fdcId);
  Future<Either<Failure, void>> removeFave(int fdcId);
  Future<Either<Failure, bool>> isFave(int fdcId);
}
