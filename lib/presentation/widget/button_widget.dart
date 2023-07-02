import 'package:flutter/material.dart';
import 'package:sneaker_shop/utils/resource/image_path.dart';
import 'package:sneaker_shop/utils/style/base_color.dart';
import 'package:sneaker_shop/utils/style/base_text_style.dart';

class ButtonWidget {
  static Widget add({
    required VoidCallback onTap,
    final bool isSelected= false,
  }) {
    return GestureDetector(
        onTap: isSelected? null: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: BaseColor.yellow,
          ),
          child: isSelected? ButtonWidget.icon(onTap: (){}, icon: ImagePath.check, radius: 40) : Container(
              padding: const EdgeInsets.all(8),
              color: Colors.transparent,
              child: Text(
                'ADD TO CART',
                style: TxtStyle.title(fontSize: 16),
              )),
        ));
  }

  static Widget icon({
    required VoidCallback onTap,
    required String icon,
    required double radius,
    Color? color,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? BaseColor.yellow,
              ),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.transparent,
            child: Image.asset(
              icon,
              height: 24,
              width: 24,
            ),
          ),
        ));
  }
}
