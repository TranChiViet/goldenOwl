import 'package:bloc/bloc.dart';
import 'package:sneaker_shop/domain/entity/shoe.dart';
import 'package:sneaker_shop/domain/repository/shoe_repository.dart';

part 'shoes_controller_state.dart';

class ShoesControllerCubit extends Cubit<ShoesControllerState> {
  ShoesControllerCubit() : super(ShoesControllerInitial());

  final ShoeRepository _shoesRepository = ShoeRepository();

  Future<void> addToCart({required Shoe shoe}) async {
    await _shoesRepository.addToCart(shoe: shoe);
    emit(ShoesControllerSuccess());
  }
}
