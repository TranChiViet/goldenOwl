import 'package:bloc/bloc.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/domain/entity/shoe.dart';
import 'package:sneaker_shop/domain/repository/cart_repository.dart';
import 'package:sneaker_shop/domain/repository/shoe_repository.dart';
part 'shoes_state.dart';

class ShoesCubit extends Cubit<ShoesState> {
  ShoesCubit() : super(ShoesInitial());

  final ShoeRepository _shoesRepository = ShoeRepository();
  final CartRepository _cartsRepository = CartRepository();

  Future<void> getShoe() async {
    clean();
    final shoes = await _shoesRepository.getShoe();
    final cart = await _cartsRepository.getCart();

    for (var shoe in shoes) {
      bool isInCart = cart.any((cart) => cart.shoe.id == shoe.id);
      shoe.isSelected = isInCart;
    }

    emit(ShoesSuccess(shoes: shoes, cart: cart));
  }

  void clean() {
    emit(ShoesInitial());
  }
}
