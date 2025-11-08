import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:test/test.dart';

class MockFavesRepository extends Mock implements FavesRepository {}

class SomeFailure extends Failure {}

void main() {
  late AddToFaveUseCase usecase;
  late MockFavesRepository mockFavesRepository;

  setUp(() {
    mockFavesRepository = MockFavesRepository();
    usecase = AddToFaveUseCase(mockFavesRepository);

    registerFallbackValue(const IdParams(fdcId: 0));
  });

  const tId = 123;
  const tParams = IdParams(fdcId: tId);

  test('should add fave (Right)', () async {
    //=========================================================================
    //! arrange
    when(() => mockFavesRepository.addFave(any()))
        .thenAnswer((_) async => const Right(null));

    //=========================================================================
    //! act
    final result = await usecase(tParams);

    //=========================================================================
    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (_) => expect(true, true), // no data to compare (void)
    );

    verify(() => mockFavesRepository.addFave(tId)).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should return Failure (Left)', () async {
    //=========================================================================
    //! arrange
    final failure = SomeFailure();
    when(() => mockFavesRepository.addFave(tId))
        .thenAnswer((_) async => Left(failure));

    //=========================================================================
    //! act
    final result = await usecase(tParams);

    //=========================================================================
    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFavesRepository.addFave(tId)).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });
}
