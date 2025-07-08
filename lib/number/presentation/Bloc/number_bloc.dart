import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';
import 'package:nutrivita_demo_v2/number/data/repository/number_repository.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';

part 'number_state.dart';

class NumberBloc extends Bloc<NumberEvent, NumbersState> {
  NumberBloc({required this.numberRepository}) : super(const NumbersState()) {
    on<GetNumbersEvent>(_mapGetNumbersEventToState);
    on<SelectNumber>(_mapSelectNumberEventToState);
  }

  final NumberRepository numberRepository;

  void _mapGetNumbersEventToState(
    GetNumbersEvent event,
    Emitter<NumbersState> emit,
  ) async {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      final numbers = await numberRepository.loadListNumbers();

      emit(
        state.copyWith(
          numbers: numbers,
          allNumbers: numbers, // <-- zapamiętaj pełną listę
          delayedResult: const DelayedResult.fromValue('Success'),
        ),
      );
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }

  void _mapSelectNumberEventToState(
    SelectNumber event,
    Emitter<NumbersState> emit,
  ) {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      emit(
        state.copyWith(
          numberSelected: event.numberSelected,
          delayedResult: const DelayedResult.fromValue(
            'Number selected successfully',
          ),
        ),
      );
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }
}
