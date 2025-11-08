import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/is_fave.dart';
import 'package:test/test.dart';

class MockFavesRepository extends Mock implements FavesRepository {}
class SomeFailure extends Failure {}

void main() {
  late IsFave usecase;
  late MockFavesRepository mockFavesRepository;

  const tFdcId = 123;

  setUp(() {
    mockFavesRepository = MockFavesRepository();
    usecase = IsFave(mockFavesRepository);
  });

  test('should return true if item is favourite (Right)', () async {
    //! arrange
    when(() => mockFavesRepository.isFave(tFdcId))
        .thenAnswer((_) async => const Right(true));

    //! act
    final result = await usecase(const IdParams(fdcId: tFdcId));

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, true),
    );

    verify(() => mockFavesRepository.isFave(tFdcId)).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should return false if item is not favourite (Right)', () async {
    //! arrange
    when(() => mockFavesRepository.isFave(tFdcId))
        .thenAnswer((_) async => const Right(false));

    //! act
    final result = await usecase(const IdParams(fdcId: tFdcId));

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, false),
    );

    verify(() => mockFavesRepository.isFave(tFdcId)).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });

  test('should return Failure (Left)', () async {
    //! arrange
    final failure = SomeFailure();
    when(() => mockFavesRepository.isFave(tFdcId))
        .thenAnswer((_) async => Left(failure));

    //! act
    final result = await usecase(const IdParams(fdcId: tFdcId));

    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFavesRepository.isFave(tFdcId)).called(1);
    verifyNoMoreInteractions(mockFavesRepository);
  });
}
