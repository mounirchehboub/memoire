part of 'Bloc.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitProductState extends ProductState {}

class LoadProductState extends ProductState {}

class LoadeedProductState extends ProductState {
  List<Product> products;
  LoadeedProductState({required this.products});
  @override
  List<Object> get props => [products];
}

class FailedLoadingProductState extends ProductState {
  String error;
  FailedLoadingProductState({required this.error});
}

class categoryLoadingState extends ProductState {}

class categoryLoadedStated extends ProductState {
  List<Product> categoryProducts;
  categoryLoadedStated({required this.categoryProducts});
  @override
  List<Object> get props => [categoryProducts];
}

class categoryFailedLoadingState extends ProductState {
  String error;
  categoryFailedLoadingState({required this.error});
}
