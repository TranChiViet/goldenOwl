import 'package:flutter/material.dart';

class ShoeModel {
  late int id;
  late double price;
  late String name;
  late String description;
  late String image;
  late String color;

  ShoeModel({
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

  ShoeModel.fromJson(Map<String, dynamic> json) {
      id= json['id'];
      price= json['price'].toDouble();
      name= json['name'];
      description= json['description'];
      image= json['image'];
      color= json['color'];
    
  }
}
