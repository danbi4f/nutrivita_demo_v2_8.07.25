import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves.dart';
import 'package:test/test.dart';

class MockFavesRepository extends Mock implements FavesRepository {}

class SomeFailure extends Failure {}

void main() {
  late GetFaves usecase;
  late MockFavesRepository mockFavesRepository;

  setUp(() {
    mockFavesRepository = MockFavesRepository();
    usecase = GetFaves(mockFavesRepository);
  });

  final tFavesList = [123, 456];

  test('should get faves from the repository (Right)', () async {
    //=========================================================================
    //! arrange
    when(() => mockFavesRepository.getFaves())
        .thenAnswer((_) async => Right(tFavesList));

    //=========================================================================
    //! act
    final result = await usecase(NoParams());

    //=========================================================================
    //! assert
    expect(result.isRight(), true); // we check that it is Right
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, tFavesList),
    );

    verify(() => mockFavesRepository.getFaves()).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should return empty list (Right)', () async {
    //=========================================================================
    //! arrange
    when(() => mockFavesRepository.getFaves())
        .thenAnswer((_) async => Right([]));

    //=========================================================================
    //! act
    final result = await usecase(NoParams());

    //=========================================================================
    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, isEmpty),
    );

    verify(() => mockFavesRepository.getFaves()).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should return Failure (Left)', () async {
    //=========================================================================
    //! arrange
    final failure = SomeFailure();
    when(() => mockFavesRepository.getFaves())
        .thenAnswer((_) async => Left(failure));

    //=========================================================================
    //! act
    final result = await usecase(NoParams());

    //=========================================================================
    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFavesRepository.getFaves()).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });
}
