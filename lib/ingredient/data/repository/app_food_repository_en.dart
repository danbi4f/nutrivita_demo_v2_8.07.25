import 'package:nutrivita_demo_v2/ingredient/data/model/en/final_food_en.dart';
import 'package:nutrivita_demo_v2/ingredient/data/service/asset_json_service_en.dart';

class AppFoodRepositoryEN {
  AppFoodRepositoryEN(this.assetJsonServiceEN);

  final AssetJsonServiceEN assetJsonServiceEN;

  Future<List<FinalFoodEN>> fetchFinalFoodsEN() {
    return assetJsonServiceEN.loadListFinalFoodEN();
  }
}
