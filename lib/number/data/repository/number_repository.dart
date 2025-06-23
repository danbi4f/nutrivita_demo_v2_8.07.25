import 'package:nutrivita_demo_v2/number/data/model/number.dart';
import 'package:nutrivita_demo_v2/number/data/service/asset_number_service.dart';

class NumberRepository {
  NumberRepository(this.assetNumberService);

  final AssetNumberService assetNumberService;

  Future<List<Number>> loadListNumbers() async {
    return assetNumberService.loadListNumbers();
  }
}
