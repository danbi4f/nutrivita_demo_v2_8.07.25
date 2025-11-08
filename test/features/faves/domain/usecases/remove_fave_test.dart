import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';
import 'package:test/test.dart';

class MockFavesRepository extends Mock implements FavesRepository {}

class SomeFailure extends Failure {}

void main() {
  late RemoveFaveUseCase usecase;
  late MockFavesRepository mockFavesRepository;

  setUp(() {
    mockFavesRepository = MockFavesRepository();
    usecase = RemoveFaveUseCase(mockFavesRepository);
  });

  const tFdcId = 123;

  test('should remove fave from the repository (Right)', () async {
    //=========================================================================
    //! arrange
    when(() => mockFavesRepository.removeFave(tFdcId))
        .thenAnswer((_) async => const Right(null));

    //=========================================================================
    //! act
    final result = await usecase(const IdParams(fdcId: tFdcId));

    //=========================================================================
    //! assert
    expect(result.isRight(), true);


    verify(() => mockFavesRepository.removeFave(tFdcId)).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should return Failure (Left)', () async {
    //=========================================================================
    //! arrange
    final failure = SomeFailure();
    when(() => mockFavesRepository.removeFave(tFdcId))
        .thenAnswer((_) async => Left(failure));

    //=========================================================================
    //! act
    final result = await usecase(const IdParams(fdcId: tFdcId));

    //=========================================================================
    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFavesRepository.removeFave(tFdcId)).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });
}
