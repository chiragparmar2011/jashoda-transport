import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';

class TextStyles {
  TextStyle textStylesNunito({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: "Nunito",
      height: height,
    );
  }

  TextStyle textStylesMontserrat({
    double? fontSize,
    Color? color,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: "Montserrat",
      height: height,
    );
  }

  TextStyle get textStyle16Black => const TextStyle(
        fontSize: 16,
        color: AppColors.white,
        fontFamily: "Nunito",
        fontWeight: FontWeight.w400,
      );

  TextStyle get textStyle14Black => const TextStyle(
        fontSize: 14,
        color: AppColors.white,
        fontFamily: "Nunito",
        fontWeight: FontWeight.w400,
      );
}
