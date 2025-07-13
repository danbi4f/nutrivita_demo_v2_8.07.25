import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/category_group_success_widget.dart';

class CategoryGroupWidget extends StatelessWidget {
  const CategoryGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryGroupBloc, CategoryGroupState>(
      builder: (context, state) => CategoryGroupSuccessWidget(),
    );
  }
}
