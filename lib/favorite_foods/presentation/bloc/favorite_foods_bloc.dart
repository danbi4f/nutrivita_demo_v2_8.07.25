import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_foods_event.dart';
part 'favorite_foods_state.dart';

class FavoriteFoodsBloc extends Bloc<FavoriteFoodsEvent, FavoriteFoodsState> {
  FavoriteFoodsBloc() : super(FavoriteFoodsInitial()) {
    on<FavoriteFoodsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
