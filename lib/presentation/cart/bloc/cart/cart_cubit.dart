import 'package:bloc/bloc.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/domain/repository/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final CartRepository _cartsRepository = CartRepository();

  Future<void> getCart() async {
    final response = await _cartsRepository.getCart();
    print(response);
    emit(CartSuccess(cart: response));
  }
}
