import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_shop/data/config/service/local_service_client.dart';
import 'package:sneaker_shop/data/model/cart_model.dart';
import 'package:sneaker_shop/data/model/shoe_model.dart';

abstract class CartLocalDatasourceInterface {
  Future<List<dynamic>> getCart();
  Future<void> saveCarts(List<CartModel> carts);
  Future<void> removeFromCart(ShoeModel shoe);
}

class CartLocalDatasource implements CartLocalDatasourceInterface {
  static const cartKey = 'cartItems';

  @override
  Future<List<CartModel>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartData = prefs.getString(cartKey);
    if (cartData != null) {
      List<dynamic> cartJson = jsonDecode(cartData);
      List<CartModel> cartItems =
          cartJson.map((json) => CartModel.fromJson(json)).toList();
      return cartItems;
    }

    return [];
  }

  @override
  Future<void> saveCarts(List<CartModel> carts) async {
    final String result = json.encode(carts);
    await LocalServiceClient.save(key: cartKey, value: result);
  }

  @override
  removeFromCart(ShoeModel shoe) async {
    final cartItems = await getCart();
    cartItems.removeWhere((item) => item.shoe.id == shoe.id);
    await saveCarts(cartItems);
  }
}
