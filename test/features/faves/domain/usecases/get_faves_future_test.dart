import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_future.dart';
import 'package:test/test.dart';

class MockFavesRepository extends Mock implements FavesRepository {}

class SomeFailure extends Failure {}

void main() {
  late GetFavesFuture usecase;
  late MockFavesRepository mockFavesRepository;

  setUp(() {
    mockFavesRepository = MockFavesRepository();
    usecase = GetFavesFuture(mockFavesRepository);
  });

  final tFavesList = [123, 456];

  test('should get faves list from repository (Right)', () async {
    //=========================================================================
    //! arrange
    when(() => mockFavesRepository.favesFuture)
        .thenAnswer((_) async => Right(tFavesList));

    //=========================================================================
    //! act
    final result = await usecase(NoParams());

    //=========================================================================
    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, tFavesList),
    );

    verify(() => mockFavesRepository.favesFuture).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should return Failure (Left)', () async {
    //=========================================================================
    //! arrange
    final failure = SomeFailure();
    when(() => mockFavesRepository.favesFuture)
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

    verify(() => mockFavesRepository.favesFuture).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });
}
