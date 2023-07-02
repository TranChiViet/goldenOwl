import 'package:flutter/material.dart';
import 'package:sneaker_shop/data/model/shoe_model.dart';
import 'package:sneaker_shop/utils/helper/color_helper.dart';

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



  Shoe.fromModel(ShoeModel shoeModel) {
      id= shoeModel.id;
      price= shoeModel.price.toDouble();
      name= shoeModel.name;
      description= shoeModel.description;
      image= shoeModel.image;
      color= ColorHelper.getColorFromHex(shoeModel.color);
  }
}
