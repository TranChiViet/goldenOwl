import 'package:sneaker_shop/data/datasource/remote/shoe_remote_datasource.dart';
import 'package:sneaker_shop/domain/entity/shoe.dart';

abstract class ShoeRepositoryInterface {
  Future<List<Shoe>> getShoe();

  Future<void> addToCart({required Shoe shoe});
}

class ShoeRepository extends ShoeRepositoryInterface {
  final ShoeRemoteDatasource _shoeRemoteDatasource = ShoeRemoteDatasource();

  @override
  Future<List<Shoe>> getShoe() async {
    try {
      final response = await _shoeRemoteDatasource.getShoes();
      List<Shoe> shoes = response.map((shoe) {
        return Shoe.fromModel(shoe);
      }).toList();
      return shoes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addToCart({required Shoe shoe}) async {
    try {
      await _shoeRemoteDatasource.addToCart(shoe: shoe);
      return;
    } catch (e) {
      rethrow;
    }
  }
}


