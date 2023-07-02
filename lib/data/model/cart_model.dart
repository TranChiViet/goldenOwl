import 'package:sneaker_shop/data/model/shoe_model.dart';

class CartModel {
  late ShoeModel shoe;
  late int quantity;

  CartModel({
    required this.shoe,
    this.quantity = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'shoe': shoe,
      'quantity': quantity,
    };
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    shoe = ShoeModel.fromJson(json['shoe']);
    quantity = json['quantity'];
  }
}
