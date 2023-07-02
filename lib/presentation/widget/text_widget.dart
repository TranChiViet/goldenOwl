import 'package:flutter/material.dart';
import 'package:sneaker_shop/utils/style/base_text_style.dart';

class TextWidget {
  static Widget title(
      {required String text, int? maxLines, Color? color, double? fontSize}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        text,
        style: TxtStyle.title(color: color, fontSize: fontSize),
        maxLines: maxLines ?? 1,
      ),
    );
  }

  static Widget description(
      {required String text, Color? color, double? fontSize}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        text,
        style: TxtStyle.description(color: color, fontSize: fontSize),
      ),
    );
  }
}
