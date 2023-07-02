import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_shop/data/config/service/local_service_client.dart';
import 'package:sneaker_shop/data/model/cart_model.dart';

abstract class CartLocalDatasourceInterface {
  Future<List<dynamic>> getCart();
  Future<void> saveCarts(List<CartModel> carts);
  Future<void> removeCart({required CartModel cartModel});
  Future<void> inCreaseCart({required CartModel cartModel});
  Future<void> deCreaseCart({required CartModel cartModel});
  Future<double> getTotal();
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
  Future<void> removeCart({required CartModel cartModel}) async {
    final cartItems = await getCart();
    cartItems.removeWhere((item) => item.shoe.id == cartModel.shoe.id);
    await saveCarts(cartItems);
  }

  @override
  Future<void> inCreaseCart({required CartModel cartModel}) async {
    final cartItems = await getCart();
    CartModel product =
        cartItems.firstWhere((item) => item.shoe.id == cartModel.shoe.id);
    product.quantity++;
    await saveCarts(cartItems);
  }

  @override
  Future<void> deCreaseCart({required CartModel cartModel}) async {
    final cartItems = await getCart();
    CartModel product =
        cartItems.firstWhere((item) => item.shoe.id == cartModel.shoe.id);
    product.quantity--;
    if (product.quantity == 0) {
      cartItems.removeWhere((item) => item.shoe.id == cartModel.shoe.id);
    }

    await saveCarts(cartItems);
  }

  @override
  Future<double> getTotal() async {
    final cartItems = await getCart();
    double totalPrice = 0;
    for (CartModel cart in cartItems) {
      totalPrice += cart.shoe.price * cart.quantity;
    }
    return totalPrice;
  }
}
