part of 'Bloc.dart';

abstract class ProduitEvent {
  const ProduitEvent();
}

class ProduitAddEvent extends ProduitEvent {
  final Product product;
  ProduitAddEvent({required this.product});
}

class ProduitDeleteEvent extends ProduitEvent {}

class ProduitEditEvent extends ProduitEvent {}

class ProductbyTitleEvent extends ProduitEvent {
  final List<Product> titleProducts;
  final String title;
  ProductbyTitleEvent({required this.titleProducts, required this.title});
}

class DeleteEvent extends ProduitEvent {
  final String uid;
  DeleteEvent({required this.uid});
}
