import 'package:flutter/material.dart';
import 'package:sneaker_shop/data/model/shoe_model.dart';

class Shoe {
  late int id;
  late double price;
  late String name;
  late String description;
  late String image;
  late Color color;

  Shoe({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.image,
    required this.color,
  });

  Color _getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  int colorValue = int.parse(hexColor, radix: 16);
  return Color(colorValue);
}

  Shoe.fromModel(ShoeModel shoeModel) {
   
      id= shoeModel.id;
      price= shoeModel.price.toDouble();
      name= shoeModel.name;
      description= shoeModel.description;
      image= shoeModel.image;
      color= _getColorFromHex(shoeModel.color);
    
  }
}
