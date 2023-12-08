import 'package:flutter/material.dart';
import 'package:student_details/utils/constants/themes/app_text_styles.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.bodyColorDark,
      hintColor: AppColor.textColor,
      primaryColorLight: AppColor.buttonBackgroundColorDark,
      appBarTheme: AppBarTheme(
          color: AppColor.appBarColor,
          centerTitle: true,
          titleTextStyle: AppTextStyles.appBarText),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor: MaterialStatePropertyAll(AppColor.iconColor))),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary, buttonColor: Colors.white),
      iconTheme: IconThemeData(color: AppColor.iconColor, weight: 30),
      dividerTheme: DividerThemeData(color: AppColor.dividerColor),
      cardTheme: CardTheme(elevation: 0,
          color: AppColor.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(AppColor.buttonBackgroundColor),
              elevation: const MaterialStatePropertyAll(10),
              textStyle:
                  MaterialStatePropertyAll(AppTextStyles.elevatedButtonText),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))))));
}
