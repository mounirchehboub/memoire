part of 'Bloc.dart';

abstract class SearchEvent {
  SearchEvent();
}

class SearchEventLoadData extends SearchEvent {
  String searchText;
  List<Product> dataList;

  SearchEventLoadData({required this.searchText, required this.dataList});
}

class SearchEventPopSearch extends SearchEvent {}
