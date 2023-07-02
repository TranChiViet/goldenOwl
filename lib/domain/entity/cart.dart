import 'package:sneaker_shop/data/model/cart_model.dart';
import 'package:sneaker_shop/data/model/shoe_model.dart';

class Cart {
  late ShoeModel shoe;
  late int quantity;

  Cart({
    required this.shoe,
    this.quantity = 1,
  });

  Cart.fromModel(CartModel cartModel) {
    shoe = cartModel.shoe;
    quantity = cartModel.quantity;
  }
}
