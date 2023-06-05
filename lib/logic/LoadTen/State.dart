part of 'Bloc.dart';

abstract class TenProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitTenProductState extends TenProductState {
  @override
  List<Object> get props => [];
}

class LoadingTenProductState extends TenProductState {
  @override
  List<Object> get props => [];
}

class LoadedTenProductState extends TenProductState {
  final List<Product> TenProducts;
  LoadedTenProductState({required this.TenProducts});

  @override
  List<Object> get props => [TenProducts];
}

class FailedLoadingTenProductState extends TenProductState {
  final String error;
  FailedLoadingTenProductState({required this.error});
  @override
  List<Object> get props => [error];
}
