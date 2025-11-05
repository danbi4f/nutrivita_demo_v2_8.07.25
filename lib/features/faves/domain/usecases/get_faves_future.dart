import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class GetFavesFuture implements UseCase<List<int>, NoParams> {
  final FavesRepository repository;

  GetFavesFuture(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    try {
      final data = await repository.favesFuture;
      return Right(data);
    } catch (_) {
      return Left(DatabaseFailure());
    }
  }
}
