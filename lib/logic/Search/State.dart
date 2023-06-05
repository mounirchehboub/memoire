part of 'Bloc.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateLoaded extends SearchState {
  final String strSearch;
  final List<Product> dataList;

  SearchStateLoaded({required this.strSearch, required this.dataList});

  @override
  List<Object> get props => [strSearch, dataList];
}

class SearchStateError extends SearchState {
  final String errorMessage;
  SearchStateError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
