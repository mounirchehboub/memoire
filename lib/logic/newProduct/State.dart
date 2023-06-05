part of 'Bloc.dart';

abstract class ProduitState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitProduitState extends ProduitState {
  @override
  List<Object> get props => [];
}

class LoadingProduitState extends ProduitState {}

class LoadedProduitState extends ProduitState {}

class FailedLoadingProduitState extends ProduitState {
  String error;
  FailedLoadingProduitState({required this.error});
}

class LoadingTtileProduitState extends ProduitState {}

class LoadedTitleProduitState extends ProduitState {
  final List<Product> titleProducts;

  LoadedTitleProduitState({required this.titleProducts});
}

class FailedLoadingTitleProduitState extends ProduitState {
  final String error;

  FailedLoadingTitleProduitState({required this.error});
}

class LoadingDeletingState extends ProduitState {
  @override
  List<Object> get props => [];
}

class LoadedDeletingState extends ProduitState {
  @override
  List<Object> get props => [];
}

class FailedDeletingState extends ProduitState {
  final String error;

  FailedDeletingState({required this.error});
  @override
  List<Object> get props => [];
}
