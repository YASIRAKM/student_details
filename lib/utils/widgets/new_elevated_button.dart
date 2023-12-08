import 'package:flutter/material.dart';
import 'package:student_details/utils/constants/themes/app_color.dart';
import 'package:student_details/utils/constants/themes/app_text_styles.dart';

class NewElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool dark;

  const NewElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonText, required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:  ButtonStyle(backgroundColor: MaterialStatePropertyAll(dark?AppColor.iconColor:null),
            elevation:const  MaterialStatePropertyAll(10),
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))))),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: AppTextStyles.elevatedText,
        ));
  }
}
