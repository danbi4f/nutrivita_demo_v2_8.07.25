import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';
import 'package:nutrivita_demo_v2/number/data/repository/number_repository.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';

part 'number_state.dart';

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  NumberBloc(this.numberRepository) : super(NumberInitial()) {
    on<GetNumbersEvent>(_mapGetNumbersEventToState);
    on<SelectNumber>(_mapSelectNumberEventToState);
  }

  final NumberRepository numberRepository;

  void _mapGetNumbersEventToState(
    GetNumbersEvent event,
    Emitter<NumberState> emit,
  ) async {
    emit(NumberLoading());
    try {
      final numbers = await numberRepository.loadListNumbers();
      emit(NumberLoaded(numbers: numbers));
    } catch (e) {
      emit(NumberError(e.toString()));
    }
  }

  void _mapSelectNumberEventToState(
    SelectNumber event,
    Emitter<NumberState> emit,
  ) {
    final loadedState = state as NumberLoaded;
    emit(loadedState.copyWith(numberSelected: event.numberSelected));
  }
}
