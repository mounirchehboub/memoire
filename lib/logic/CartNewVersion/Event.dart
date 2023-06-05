part of 'Bloc.dart';

abstract class CartProductEvent extends Equatable {
  const CartProductEvent();

  @override
  List<Object> get props => [];
}

class AddCartProduct extends CartProductEvent {
  final Product product;
  final String startRent;
  final String endRent;
  final int dayRange;
  int hourRange;
  AddCartProduct(
      {required this.product,
      required this.startRent,
      required this.endRent,
      required this.dayRange,
      this.hourRange = 0});
  @override
  List<Object> get props => [product];
}

class RemoveCartProduct extends CartProductEvent {
  final Product product;
  final String startRent;
  final String endRent;
  final int dayRange;
  int hourRange;

  RemoveCartProduct(
      {required this.product,
      required this.startRent,
      required this.endRent,
      required this.dayRange,
      this.hourRange = 0});
  @override
  List<Object> get props => [product];
}

class ResetCartProduct extends CartProductEvent {}

class RemoveAll extends CartProductEvent {}

class SubmitValidationEvent extends CartProductEvent {
  String phoneNumber;
  String permisNumber = '';
  String cartIdNumber = '';
  SubmitValidationEvent(
      {required this.phoneNumber,
      required this.permisNumber,
      required this.cartIdNumber});
}

class CalculatePrice extends CartProductEvent {
  Cart cartProduct;
  CalculatePrice({required this.cartProduct});
  @override
  List<Object> get props => [cartProduct];
}
