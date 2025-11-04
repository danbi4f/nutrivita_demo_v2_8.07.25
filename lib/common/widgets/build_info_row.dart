import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';

class BuildInfoRow extends StatelessWidget {
  const BuildInfoRow({
    super.key,
    required this.context,
    required this.label,
    required this.value,
  });

  final BuildContext context;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body(context, isBold: true)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.body(context),
            ),
          ),
        ],
      ),
    );
  }
}
