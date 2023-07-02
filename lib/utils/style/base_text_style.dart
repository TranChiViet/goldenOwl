import 'package:flutter/material.dart';
import 'package:sneaker_shop/utils/style/base_color.dart';

class TxtStyle {
  static String baseBoldFont = "RubikBold";
  static String baseRegularFont = "RubikRegular";
  static String baseSemiBoldFont = "RubikSemiBold";

  static TextStyle topic({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: TxtStyle.baseBoldFont,
        fontSize: fontSize ?? 32,
        color: color ?? BaseColor.black);
  }

  static TextStyle title({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: TxtStyle.baseBoldFont,
        fontSize: fontSize ?? 20,
        color: color ?? BaseColor.black);
  }

  static TextStyle description({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: TxtStyle.baseRegularFont,
        fontSize: fontSize ?? 16,
        color: color ?? BaseColor.grey);
  }
}
