import 'package:flutter/material.dart';

import '../constants/themes/app_color.dart';
import '../constants/themes/app_text_styles.dart';

class NewIconColumnTextWidget extends StatelessWidget {
  final IconData iconData;
  final String type;
  final VoidCallback onTap;

  const NewIconColumnTextWidget({
    super.key,
    required this.ht,
    required this.iconData,
    required this.wt,
    required this.type,
    required this.onTap,
  });

  final double ht;
  final double wt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: ht * .1,
        width: wt * .2,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.iconColor),
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              iconData,
              size: ht * .05,
            ),
            Text(
              type,
              style: AppTextStyles.labelText,
            )
          ],
        ),
      ),
    );
  }
}