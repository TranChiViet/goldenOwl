import 'package:flutter/material.dart';
import 'package:sneaker_shop/utils/style/base_text_style.dart';

class TextWidget{
  static Widget title({required String text}){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(text, style: TxtStyle.title(),),
    );
  }

  static Widget description({required String text}){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(text, style: TxtStyle.description(),),
    );
  }
}