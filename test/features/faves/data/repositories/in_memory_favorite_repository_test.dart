import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:nutrivita_demo_v2/core/error/exceptions.dart';

import 'package:nutrivita_demo_v2/features/faves/data/datasources/faves_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/faves/data/repository/in_memory_favorite_repository.dart';

// mock
class MockFoodLocalDataSource extends Mock implements FavesLocalDataSource {}

void main() {
  late MockFoodLocalDataSource mockDataSource;
  late InMemoryFavesRepository repository;

  setUp(() {
    mockDataSource = MockFoodLocalDataSource();
    repository = InMemoryFavesRepository(localDataSource: mockDataSource);
  });

  // ==========================================================================
  group('init()', () {
    test('should emit initial favorites on success', () async {
      when(() => mockDataSource.getFaves()).thenAnswer((_) async => [1, 2]);

      final streamFuture = repository.favesStream.first;
      await repository.init();
      final either = await streamFuture;

      either.fold((l) => fail('should not be left'), (r) => expect(r, [1, 2]));
      verify(() => mockDataSource.getFaves()).called(1);
    });

    test(
      'should throw CacheException when datasource throws CacheException',
      () async {
        when(() => mockDataSource.getFaves()).thenThrow(CacheException());

        expect(() => repository.init(), throwsA(isA<CacheException>()));
      },
    );

    test(
      'should throw generic exception when unknown exception happens',
      () async {
        when(() => mockDataSource.getFaves()).thenThrow(Exception('boom'));

        expect(() => repository.init(), throwsException);
      },
    );
  });

  // ==========================================================================
  group('addFave()', () {
    test('should return Right(null) and emit new list', () async {
      when(() => mockDataSource.addFave(10)).thenAnswer((_) async {});

      final streamFuture = repository.favesStream.first;
      final result = await repository.addFave(10);
      final either = await streamFuture;

      expect(result.isRight(), true);
      either.fold((l) => fail('should not be left'), (r) => expect(r, [10]));
      verify(() => mockDataSource.addFave(10)).called(1);
    });

    test(
      'should return Left(CacheFailure) when datasource throws CacheException',
      () async {
        when(() => mockDataSource.addFave(10)).thenThrow(CacheException());

        final result = await repository.addFave(10);

        expect(result.isLeft(), true);
      },
    );

    test(
      'should return Left(CacheFailure) when unknown exception happens',
      () async {
        when(() => mockDataSource.addFave(10)).thenThrow(Exception('boom'));

        final result = await repository.addFave(10);

        expect(result.isLeft(), true);
      },
    );
  });

  // ==========================================================================
  group('removeFave()', () {
    test(
      'should return Right(null) and emit updated list after removal',
      () async {
        when(() => mockDataSource.addFave(10)).thenAnswer((_) async {});
        await repository.addFave(10);

        when(() => mockDataSource.removeFave(10)).thenAnswer((_) async {});

        final streamFuture = repository.favesStream.first;
        final result = await repository.removeFave(10);
        final either = await streamFuture;

        expect(result.isRight(), true);
        either.fold((l) => fail('should not be left'), (r) => expect(r, []));
        verify(() => mockDataSource.removeFave(10)).called(1);
      },
    );

    test(
      'should return Left(CacheFailure) when datasource throws CacheException',
      () async {
        when(() => mockDataSource.removeFave(10)).thenThrow(CacheException());

        final result = await repository.removeFave(10);

        expect(result.isLeft(), true);
      },
    );

    test(
      'should return Left(CacheFailure) when unknown exception happens',
      () async {
        when(() => mockDataSource.removeFave(10)).thenThrow(Exception('boom'));

        final result = await repository.removeFave(10);

        expect(result.isLeft(), true);
      },
    );
  });

  // ==========================================================================
  group('isFave()', () {
    test('should return Right(true)/Right(false) correctly', () async {
      when(() => mockDataSource.addFave(5)).thenAnswer((_) async {});
      await repository.addFave(5);

      final r1 = await repository.isFave(5);
      final r2 = await repository.isFave(10);

      expect(r1, Right(true));
      expect(r2, Right(false));
    });
  });
}
