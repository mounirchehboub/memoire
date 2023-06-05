part of 'Bloc.dart';

abstract class EditProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialEditProductState extends EditProductState {}

//StockUpdate States

class LoadingStockUpdateState extends EditProductState {}

class LoadedStockUpdateState extends EditProductState {}

class FailedStockUpdateState extends EditProductState {
  final String errorMessage;

  FailedStockUpdateState({required this.errorMessage});
}

//PromotionUpdateStates

class LoadingPromotionUpdateState extends EditProductState {}

class LoadedPromotionUpdateState extends EditProductState {}

class FailedPromotionUpdateState extends EditProductState {
  final String errorMessage;

  FailedPromotionUpdateState({required this.errorMessage});
}

class LoadingGeneralFieldsUpdateState extends EditProductState {}

class LoadedGeneralFieldsUpdateState extends EditProductState {}

class FailedGeneralFieldsUpdateState extends EditProductState {
  final String errorMessage;

  FailedGeneralFieldsUpdateState({required this.errorMessage});
}
