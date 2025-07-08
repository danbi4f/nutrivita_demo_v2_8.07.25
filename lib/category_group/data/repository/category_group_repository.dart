import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/data/service/category_group_service.dart';

class CategoryGroupRepository {
  final CategoryGroupService categoryGroupService;

  CategoryGroupRepository(this.categoryGroupService);

  Future<List<CategoryGroup>> getCategories() {
    return categoryGroupService.loadCategoryGroup();
  }
}
