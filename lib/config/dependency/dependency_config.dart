import 'package:get_it/get_it.dart';
import 'package:sneaker_shop/presentation/cart/bloc/cart/cart_cubit.dart';
import 'package:sneaker_shop/presentation/cart/bloc/cart_controller/cart_controller_cubit.dart';
import 'package:sneaker_shop/presentation/products/bloc/shoes/shoes_cubit.dart';
import 'package:sneaker_shop/presentation/products/bloc/shoes_controller/shoes_controller_cubit.dart';

Future<void> configureDependencies() async {

  //Get Data
  GetIt.instance.registerLazySingleton<ShoesCubit>(() => ShoesCubit());
  GetIt.instance.registerLazySingleton<CartCubit>(() => CartCubit());

  //Controller
  GetIt.instance.registerLazySingleton<ShoesControllerCubit>(() => ShoesControllerCubit());
  GetIt.instance.registerLazySingleton<CartControllerCubit>(() => CartControllerCubit());
}
