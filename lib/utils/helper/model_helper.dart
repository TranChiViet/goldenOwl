import 'package:sneaker_shop/data/model/cart_model.dart';
import 'package:sneaker_shop/data/model/shoe_model.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/domain/entity/shoe.dart';

class ShoeHelper {
  static ShoeModel toModel(Shoe shoe) {
    return ShoeModel(
      id: shoe.id,
      name: shoe.name,
      image: shoe.image,
      description: shoe.description,
      price: shoe.price,
      color: shoe.color.toString(),
    );
  }
}

class CartHelper {
  static CartModel toModel(Cart cart) {
    return CartModel(
      shoe: cart.shoe,
      quantity: cart.quantity,
    );
  }
}