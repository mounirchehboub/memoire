part of 'Bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductSearchEvent extends ProductEvent {
  final String search;
  ProductSearchEvent({required this.search});

  @override
  List<Object> get props => [search];
}

class ProductGetEvent extends ProductEvent {}

class ProductbyCategoryEvent extends ProductEvent {
  final List<Product> categoryProduct;
  final String cat;
  ProductbyCategoryEvent({required this.categoryProduct, required this.cat});
  @override
  List<Object> get props => [categoryProduct];
}
