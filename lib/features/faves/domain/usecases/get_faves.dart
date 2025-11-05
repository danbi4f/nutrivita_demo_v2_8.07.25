import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class GetFaves implements UseCase<List<int>, NoParams> {
  final FavesRepository repository;

  GetFaves(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    try {
      final data = await repository.getFaves();
      return Right(data);
    } catch (_) {
      return Left(DatabaseFailure());
    }
  }
}
