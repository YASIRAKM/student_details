import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_details/utils/constants/themes/app_color.dart';

class AppTextStyles{
  static TextStyle appBarText = GoogleFonts.roboto(color: AppColor.appBarTextColor,fontSize: 30);
  static TextStyle homeNameText = GoogleFonts.playfairDisplay(color: AppColor.homeNameTextColor,fontSize: 25,fontWeight:FontWeight.w400);
  static TextStyle homeAgeText = GoogleFonts.playfairDisplay(color: AppColor.homeNameTextColor,fontSize: 15);
  static TextStyle labelText = GoogleFonts.roboto(color: AppColor.labelTextColor,fontSize: 15);
  static TextStyle elevatedButtonText = GoogleFonts.roboto(color: AppColor.labelTextColor,fontSize: 15);
  static TextStyle smallText = GoogleFonts.roboto(color: AppColor.iconColor,fontSize: 16);
  static TextStyle elevatedText = GoogleFonts.dhurjati(color: AppColor.elevatedText,fontSize: 30);
}