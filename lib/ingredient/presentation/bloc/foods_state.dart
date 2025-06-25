import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';
import '../../domain/entities/food_entity.dart';

class FoodsState extends Equatable {
  const FoodsState({
    this.foods = const [],
    this.delayedResult = const DelayedResult.idle(),
  });

  final DelayedResult<String> delayedResult;
  final List<FoodEntity> foods;

  FoodsState copyWith({
    List<FoodEntity>? foods,
    DelayedResult<String>? delayedResult,
  }) {
    return FoodsState(
      foods: foods ?? this.foods,
      delayedResult: delayedResult ?? this.delayedResult,
    );
  }

  @override
  List<Object?> get props => [foods, delayedResult];
}
