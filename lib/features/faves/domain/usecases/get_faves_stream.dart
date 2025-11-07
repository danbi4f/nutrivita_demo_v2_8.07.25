import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class GetFavesStream implements StreamUseCase<List<int>, NoParams> {
  final FavesRepository repository;

  GetFavesStream(this.repository);

  @override
  Stream<Either<Failure, List<int>>> call(NoParams params) async* {
    yield* repository.favesStream;
  }
}
