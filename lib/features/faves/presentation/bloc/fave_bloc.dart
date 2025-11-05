import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_future.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_food_by_fdcid.dart';
part 'fave_event.dart';
part 'fave_state.dart';

class FaveBloc extends Bloc<FaveEvent, FaveState> {
  final GetFavesFuture favesFuture;
  final GetFavesStream favesStream;
  final AddToFaveUseCase addFave;
  final RemoveFaveUseCase removeFave;
  final GetFoodByFdcId getFoodByFdcId;

  FaveBloc({
    required this.favesFuture,
    required this.favesStream,
    required this.addFave,
    required this.removeFave,
    required this.getFoodByFdcId,
  }) : super(
         const FaveState(
           faves: [],
           loadingResult: DelayedResult.idle(),
           foods: [],
         ),
       ) {
    on<LoadFaves>(_onLoadFaves);
    on<AddFave>(_onAddFave);
    on<RemoveFave>(_onRemoveFave);
    on<ClearError>(_onClearError);
  }

 Future<void> _onLoadFaves(
      LoadFaves event, Emitter<FaveState> emit) async {
    emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));

    final failureOrIds = await favesFuture(NoParams());

    await failureOrIds.fold(
      (failure) async {
        emit(state.copyWith(
          loadingResult: DelayedResult.fromError(
            Exception(failure.toString()),
          ),
        ));
      },
      (ids) async {
        await _updateFaveFoods(ids, emit);

        await emit.forEach<Either<Failure, List<int>>>(
          favesStream(NoParams()),
          onData: (either)  {
            return either.fold(
              (_) => state,
              (list)  {
                 _updateFaveFoods(list, emit);
                return state;
              },
            );
          },
        );
      },
    );

    emit(state.copyWith(loadingResult: const DelayedResult.idle()));
  }


  Future<void> _onAddFave(AddFave event, Emitter<FaveState> emit) async {
    emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
    final failureOrData = await addFave(IdParams(fdcId: event.fdcId));

    failureOrData.fold(
      (failure) => emit(
        state.copyWith(
          loadingResult: DelayedResult.fromError(Exception(failure.toString())),
        ),
      ),
      (_) => emit(state.copyWith(loadingResult: const DelayedResult.idle())),
    );
  }

  Future<void> _onRemoveFave(RemoveFave event, Emitter<FaveState> emit) async {
    emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
    final failureOrData = await removeFave(IdParams(fdcId: event.fdcId));

    failureOrData.fold(
      (failure) => emit(
        state.copyWith(
          loadingResult: DelayedResult.fromError(Exception(failure.toString())),
        ),
      ),
      (_) => emit(state.copyWith(loadingResult: const DelayedResult.idle())),
    );
  }

  void _onClearError(ClearError event, Emitter emit) {
    emit(state.copyWith(loadingResult: const DelayedResult.idle()));
  }

  Future<void> _updateFaveFoods(List<int> fdcIds, Emitter<FaveState> emit) async {
  final foods = <Food>[];
  for (final fdcId in fdcIds) {
    final failureOrData = await getFoodByFdcId(fdcId);
    failureOrData.fold(
      (_) => null, // we ignore mistakes
      (food) => foods.add(food),
    );
  }
  emit(state.copyWith(faves: fdcIds, foods: foods));
}
}
