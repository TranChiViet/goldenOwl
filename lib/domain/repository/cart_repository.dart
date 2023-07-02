import 'package:sneaker_shop/data/datasource/local/cart_local_datasource.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';

abstract class CartRepositoryInterface {
  Future<List<Cart>> getCart();

  // Future<void> addToCart({required ShoeModel shoe});
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

}