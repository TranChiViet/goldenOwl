import 'package:bloc/bloc.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/domain/repository/cart_repository.dart';

part 'cart_controller_state.dart';

class CartControllerCubit extends Cubit<CartControllerState> {
  CartControllerCubit() : super(CartControllerInitial());
  final CartRepository _cartRepository = CartRepository();

   Future<void> removeCart({required Cart cart}) async {
    await _cartRepository.removeCart(cart: cart);
    emit(CartControllerSuccess());
  }

  Future<void> inCreaseCart({required Cart cart}) async {
    await _cartRepository.inCreaseCart(cart: cart);
    emit(CartControllerSuccess());
  }


Future<void> deCreaseCart({required Cart cart}) async {
    await _cartRepository.deCreaseCart(cart: cart);
    emit(CartControllerSuccess());
  }



  void clean() {
    emit(CartControllerInitial());
  }
}
