import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';

class CategoryGroupService {
  Future<List<CategoryGroup>> loadCategoryGroup() async {
    final jsonString = await rootBundle.loadString(
      'assets/category_group.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    final List categories = jsonData['category'];

    return categories.map((json) => CategoryGroup.fromJson(json)).toList();
  }
}
