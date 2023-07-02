part of 'shoes_cubit.dart';

abstract class ShoesState {}

class ShoesSuccess extends ShoesState {
  final List<Shoe> shoes;

  ShoesSuccess({required this.shoes});
}

class ShoesInitial extends ShoesState {}
