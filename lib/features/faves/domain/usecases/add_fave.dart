import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class AddToFaveUseCase implements UseCase<void, Params> {
  final FavesRepository repository;

  AddToFaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    try {
      final data = await repository.addFave(params.fdcId);
      return Right(data);
    } catch (_) {
      return Left(DatabaseFailure());
    }
  }
}


