import 'package:bloc/bloc.dart';
import 'package:sneaker_shop/domain/entity/shoe.dart';
import 'package:sneaker_shop/domain/repository/shoe_repository.dart';
part 'shoes_state.dart';

class ShoesCubit extends Cubit<ShoesState> {
  ShoesCubit() : super(ShoesInitial());

  final ShoeRepository _shoesRepository = ShoeRepository();

  Future<void> getShoe() async {
    emit(ShoesInitial());
    final response = await _shoesRepository.getShoe();
    emit(ShoesSuccess(shoes: response));
  }
}
