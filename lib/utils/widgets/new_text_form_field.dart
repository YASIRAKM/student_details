import 'package:flutter/material.dart';
import 'package:student_details/utils/constants/themes/app_color.dart';
import 'package:student_details/utils/constants/themes/app_text_styles.dart';

class NewTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData iconData;
  final dynamic validator;
  final TextInputType keyBoardType;
  final bool dark;


  const NewTextFieldWidget({
    super.key,
    required this.controller,
    required this.iconData,
    required this.labelText, required this.validator, required this.keyBoardType, required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color:dark?AppColor.bodyColorDark :AppColor.appBarTextColor,width: 1.5)),
      child: TextFormField(keyboardType: keyBoardType,
        validator:validator ,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none
              ,
              labelText: labelText,labelStyle: AppTextStyles.labelText,iconColor: AppColor.iconColor,
              prefixIcon: Icon(iconData, color: AppColor.iconColor ,))),
    );
  }
}
