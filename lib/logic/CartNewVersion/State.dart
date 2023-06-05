part of 'Bloc.dart';

abstract class CartProductState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class CartAction extends CartProductState {}

class InitialCartProductState extends CartProductState {}

class LoadingCartProductState extends CartProductState {}

class LoadedCartProductState extends CartProductState {
  List<Cart> cartProducts;
  LoadedCartProductState({required this.cartProducts});
  @override
  List<Object> get props => [cartProducts];
}

class AlreadyExists extends CartProductState {}

class FailedToLoadCartProductState extends CartProductState {
  String error;
  FailedToLoadCartProductState({required this.error});
}

//Handling Actions
class RemoveAction extends CartAction {}

class AddAction extends CartAction {}

class SubmitValidatoin extends CartAction {}

class AddedCartProductState extends CartProductState {
  Color color;
  List<Cart> cartProducts;
  AddedCartProductState({required this.cartProducts, required this.color});
  @override
  List<Object> get props => [cartProducts, color];
}

class Submitting extends CartProductState {}

class SubmitSucssessful extends CartProductState {}

class ErrorSubmit extends CartProductState {
  final String error;
  ErrorSubmit({required this.error});
}
