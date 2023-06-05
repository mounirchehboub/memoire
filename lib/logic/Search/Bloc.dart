import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/firebasecall/ProductFirebase.dart';
import '../../models/ProductModel.dart';
part 'State.dart';
part 'Event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState()) {
    on<SearchEventLoadData>(_onSearchProducts);
    on<SearchEventPopSearch>(_onSearchEventPopSearch);
  }

  SearchState get initialState => InitialSearchState();
  ProductFirebase productFirebase = ProductFirebase();

  Future<void> _onSearchProducts(
    SearchEventLoadData event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchStateLoading());
      if (event.searchText.isEmpty) {
        emit(SearchStateError(errorMessage: 'Search Text should not be Empty'));
      }

      event.dataList = [];
      await productFirebase.getProdbyTitle(event.searchText).then((product) {
        for (var Product in product) {
          event.dataList.add(Product.data());
        }
      }).onError((error, stackTrace) {
        emit(SearchStateError(errorMessage: error.toString()));
        return null;
      });
      emit(SearchStateLoaded(
          dataList: event.dataList, strSearch: event.searchText));
    } catch (error) {
      emit(SearchStateError(errorMessage: error.toString()));
    }
  }

  Future<void> _onSearchEventPopSearch(
    SearchEventPopSearch event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchStateLoading());
      emit(SearchStateLoaded(strSearch: '', dataList: []));
    } catch (error) {
      emit(SearchStateError(errorMessage: error.toString()));
    }
  }
}
