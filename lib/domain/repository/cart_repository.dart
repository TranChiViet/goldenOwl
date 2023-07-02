import 'package:sneaker_shop/data/datasource/local/cart_local_datasource.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/utils/helper/model_helper.dart';

abstract class CartRepositoryInterface {
  Future<List<Cart>> getCart();
  Future<double> getTotal();
  Future<void> inCreaseCart({required Cart cart});
  Future<void> deCreaseCart({required Cart cart});
  Future<void> removeCart({required Cart cart});
}


class CartRepository extends CartRepositoryInterface {
  final CartLocalDatasource _cartLocalDatasource = CartLocalDatasource();

  @override
  Future<List<Cart>> getCart() async {
    try {
      final response = await _cartLocalDatasource.getCart();
      List<Cart> carts = response.map((cart) {
        return Cart.fromModel(cart);
      }).toList();
      return carts;
    } catch (e) {
       rethrow;
    }
  }
  @override
  Future<void> inCreaseCart({required Cart cart}) async {
    try {
      final cartModel = CartHelper.toModel(cart);
      final response = await _cartLocalDatasource.inCreaseCart(cartModel: cartModel);
      return response;
    } catch (e) {
       rethrow;
    }
  }
  @override
  Future<void> deCreaseCart({required Cart cart}) async {
    try {
      final cartModel = CartHelper.toModel(cart);
      final response = await _cartLocalDatasource.deCreaseCart(cartModel: cartModel);
      return response;
    } catch (e) {
       rethrow;
    }
  }

  @override
  Future<double> getTotal() async {
    try {
      final response = await _cartLocalDatasource.getTotal();
      return response;
    } catch (e) {
       rethrow;
    }
  }

  @override
  Future<void> removeCart({required Cart cart}) async {
    try {
      final cartModel = CartHelper.toModel(cart);
      final response = await _cartLocalDatasource.removeCart(cartModel: cartModel);
      return response;
    } catch (e) {
       rethrow;
    }
  }

}