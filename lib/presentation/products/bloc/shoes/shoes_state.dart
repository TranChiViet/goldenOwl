part of 'shoes_cubit.dart';

abstract class ShoesState {}

class ShoesSuccess extends ShoesState {
  final List<Shoe> shoes;
  final List<Cart> cart;

  ShoesSuccess({required this.shoes, required this.cart});
}

class ShoesInitial extends ShoesState {}
