part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final List<Cart> cart;

  CartSuccess({required this.cart});
}
