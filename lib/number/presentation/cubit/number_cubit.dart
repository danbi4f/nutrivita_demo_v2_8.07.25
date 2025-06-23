import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';
import 'package:nutrivita_demo_v2/number/data/repository/number_repository.dart';

part 'number_state.dart';

class NumberCubit extends Cubit<NumberState> {
  NumberCubit(this.numberRepository) : super(NumberInitial());

  final NumberRepository numberRepository;

  void loadNumbers() async {
    try {
      emit(NumberLoading());
      final numbers = await numberRepository.loadListNumbers();
      emit(NumberLoaded(numbers));
    } catch (e) {
      emit(NumberError(e.toString()));
    }
  }
}
