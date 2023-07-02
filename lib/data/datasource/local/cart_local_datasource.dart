import 'dart:convert';

import 'package:sneaker_shop/data/config/service/local_service_client.dart';
import 'package:sneaker_shop/data/model/cart_model.dart';
import 'package:sneaker_shop/data/model/shoe_model.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/domain/entity/shoe.dart';

abstract class CartLocalDatasourceInterface {
  Future<List<dynamic>> getCart();
  Future<void> addToCart({required ShoeModel shoe});
  Future<void> removeFromCart(ShoeModel shoe);
  Future<void> saveCarts(List<dynamic> carts);
}

class CartLocalDatasource implements CartLocalDatasourceInterface {
  static const cartKey = 'cartItems';

  @override
  Future<List<dynamic>> getCart() async {
    final data = await LocalServiceClient.get(cartKey);
    print(data);

    final Map<String, dynamic> jsonData = json.decode(data);
    print(jsonData);
    final List<CartModel> cartItems = (jsonData['cartItems'])
        .map((json) => CartModel.fromJson(json))
        .toList();
    print(cartItems);
    return cartItems;
  }

  @override
  Future<void> addToCart({required ShoeModel shoe}) async {
    final cartItems = await getCart();
    final existingItem = cartItems.firstWhere(
      (item) => item.shoe.id == shoe.id,
    );
    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      final newItem = CartModel(shoe: shoe, quantity: 1);
      cartItems.add(newItem);
    }
    await saveCarts(cartItems);
  }

  @override
  Future<void> removeFromCart(ShoeModel shoe) async {
    final cartItems = await getCart();
    cartItems.removeWhere((item) => item.shoe.id == shoe.id);
    await saveCarts(cartItems);
  }

  @override
  Future<void> saveCarts(List<dynamic> carts) async {
    final mapData = carts.map((cart) => cart.toString()).toList();
    final String result = jsonEncode(mapData);
    await LocalServiceClient.save(key: cartKey, value: result);
  }
}
