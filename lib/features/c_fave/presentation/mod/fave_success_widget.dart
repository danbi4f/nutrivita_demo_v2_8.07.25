import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/c_fave/presentation/mod/fave_item.dart';

class FaveSuccessWidget extends StatelessWidget {
  const FaveSuccessWidget({super.key, required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final fdcId = list[index];
        return FaveItem(fdcId: fdcId);
      },
    );
  }
}
