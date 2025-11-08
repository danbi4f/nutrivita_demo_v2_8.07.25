import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:test/test.dart';

class MockFavesRepository extends Mock implements FavesRepository {}

class SomeFailure extends Failure {}

void main() {
  late GetFavesStream usecase;
  late MockFavesRepository mockFavesRepository;

  setUp(() {
    mockFavesRepository = MockFavesRepository();
    usecase = GetFavesStream(mockFavesRepository);
  });

  final tFavesList1 = [123, 456];
  final tFavesList2 = [789];

  test('should emit faves list from repository (Right)', () async {
    //=========================================================================
    //! arrange
    when(() => mockFavesRepository.favesStream)
        .thenAnswer((_) => Stream.value(Right(tFavesList1)));

    //=========================================================================
    //! act
    final stream = usecase(NoParams());

    //=========================================================================
    //! assert
    await expectLater(
      stream,
      emitsInOrder([
        Right(tFavesList1),
      ]),
    );

    verify(() => mockFavesRepository.favesStream).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should emit Failure (Left)', () async {
    //=========================================================================
    //! arrange
    final failure = SomeFailure();
    when(() => mockFavesRepository.favesStream)
        .thenAnswer((_) => Stream.value(Left(failure)));

    //=========================================================================
    //! act
    final stream = usecase(NoParams());

    //=========================================================================
    //! assert
    await expectLater(
      stream,
      emitsInOrder([
        Left(failure),
      ]),
    );

    verify(() => mockFavesRepository.favesStream).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should emit multiple snapshots', () async {
    //=========================================================================
    //! arrange
    when(() => mockFavesRepository.favesStream).thenAnswer(
      (_) => Stream.fromIterable([
        Right(tFavesList1),
        Right(tFavesList2),
      ]),
    );

    //=========================================================================
    //! act
    final stream = usecase(NoParams());

    //=========================================================================
    //! assert
    await expectLater(
      stream,
      emitsInOrder([
        Right(tFavesList1),
        Right(tFavesList2),
      ]),
    );

    verify(() => mockFavesRepository.favesStream).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });
}
