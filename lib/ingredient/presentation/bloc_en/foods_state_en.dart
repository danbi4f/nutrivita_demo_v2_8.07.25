import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';
import 'package:nutrivita_demo_v2/ingredient/data/model/en/final_food_en.dart';

class FoodsStateEN extends Equatable {
  const FoodsStateEN({
    this.foods = const [],
    this.delayedResult = const DelayedResult.idle(),
  });

  final DelayedResult<String> delayedResult;
  final List<FinalFoodEN> foods;

  FoodsStateEN copyWith({
    List<FinalFoodEN>? foods,
    DelayedResult<String>? delayedResult,
  }) {
    return FoodsStateEN(
      foods: foods ?? this.foods,
      delayedResult: delayedResult ?? this.delayedResult,
    );
  }

  @override
  List<Object?> get props => [foods, delayedResult];
}
