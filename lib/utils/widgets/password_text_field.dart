
import 'package:flutter/material.dart';
import 'package:student_details/utils/constants/themes/app_text_styles.dart';

import '../constants/themes/app_color.dart';
import '../constants/validators.dart';

class NewTextFormFieldPasswordWidget extends StatelessWidget {
  final bool obscure;
  final TextEditingController controller;

  final IconButton iconButton;

  const NewTextFormFieldPasswordWidget({
    super.key,
    required this.obscure,
    required this.controller,
    required this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color:AppColor.appBarTextColor,width: 1.5)),
      child: TextFormField(
          keyboardType: TextInputType.text,
          validator: MyValidator.validatePassword,
          obscureText: obscure,
          obscuringCharacter: "*",
          controller: controller,
          decoration: InputDecoration(
              iconColor: AppColor.iconColor,
border: InputBorder.none,
              suffixIcon: iconButton,labelStyle: AppTextStyles.labelText,
              labelText: 'Password',
              prefixIcon:  Icon(Icons.password,color:AppColor.iconColor ,))),
    );
  }
}
