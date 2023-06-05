import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/models/ProfileModel.dart';

import '../../../constants.dart';
import '../../../logic/LoadTen/Bloc.dart';
import '../../../logic/Search/Bloc.dart';
import '../../../models/ProductModel.dart';
import 'EditProducts/GeneralFields.dart';
import 'EditProducts/PromotionUpdate.dart';
import 'EditProducts/StockUpdate.dart';

class OnePlace extends StatefulWidget {
  const OnePlace({
    Key? key,
    required this.id,
  }) : super(key: key);
  static const String OneplacePath = '/OneplacePath';
  final int id;
  @override
  _OnePlaceState createState() => _OnePlaceState();
}

class _OnePlaceState extends State<OnePlace> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appBackground,
      body: SearchwithList(
        height: height,
        width: width,
        con: context,
        id: widget.id,
      ),
    );
  }
}

class SearchwithList extends StatefulWidget {
  const SearchwithList({
    super.key,
    required this.height,
    required this.width,
    required this.con,
    required this.id,
  });
  final double height;
  final double width;
  final BuildContext con;
  final int id;
  @override
  State<SearchwithList> createState() => _SearchwithListState();
}

class _SearchwithListState extends State<SearchwithList> {
  bool isSearched = false;
  List<Product> searchedProducts = [];
  List<Product> LoadedProducts = [];
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: widget.height * 0.12,
            ),
            _buildSearchField(),
            SizedBox(
              height: widget.height * 0.05,
            ),
            searchTextController.text.isNotEmpty
                ? buildBlocBuilderSearched(widget.height, widget.width)
                : buildBlocWidget(widget.height, widget.width),
          ],
        ),
      ),
    );
  }

  BlocBuilder<TenProductBloc, TenProductState> buildBlocWidget(
      double height, double width) {
    return BlocBuilder<TenProductBloc, TenProductState>(
      builder: (context, state) {
        print("bloc state is " + state.toString());
        if (state is LoadedTenProductState) {
          LoadedProducts = state.TenProducts;
          return buildLoadedListWidget(height, width);
        }
        if (state is FailedLoadingTenProductState) {
          return Center(
            child: Text(
              state.error,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
            strokeWidth: 1.5,
          ),
        );
      },
    );
  }

  Widget buildLoadedListWidget(double height, double width) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: searchTextController.text.isNotEmpty
              ? searchedProducts.length
              : LoadedProducts.length,
          itemBuilder: (contexts, index) {
            return Container(
              margin: EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: height * 0.02),
              height: height * 0.12,
              width: width,
              decoration: BoxDecoration(
                color: buttonGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  switch (widget.id) {
                    case 1:
                      Navigator.pushReplacementNamed(
                          widget.con, GeneralFields.generalFieldsPath,
                          arguments: ScreenArguments(LoadedProducts[index]));
                      break;
                    case 2:
                      Navigator.pushNamed(
                        widget.con,
                        PromotionUpdate.promotionUpdatePath,
                        arguments: ScreenArguments(LoadedProducts[index]),
                      );
                      break;
                    case 3:
                      Navigator.pushNamed(
                        widget.con,
                        StockUpdate.stockUpdatePath,
                        arguments: ScreenArguments(LoadedProducts[index]),
                      );
                      break;
                    default:
                      print('got default ');
                  }
                },
                child: Row(
                  children: [
                    Image.network(
                      width: width * 0.2,
                      searchTextController.text.isNotEmpty
                          ? searchedProducts[index].images.first
                          : LoadedProducts[index].images.first.toString(),
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Text(searchTextController.text.isNotEmpty
                        ? searchedProducts[index].title
                        : LoadedProducts[index].title),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget buildBlocBuilderSearched(double height, double width) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (contexts, state) {
      print(state);
      if (state is SearchStateLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
            strokeWidth: 1.5,
          ),
        );
      }
      if (state is SearchStateError) {
        return Center(
          child: Text(
            state.errorMessage,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }
      if (state is SearchStateLoaded) {
        searchedProducts = state.dataList;
        return buildLoadedListWidget(height, width);
      }
      return Container();
    });
  }

  Widget _buildSearchField() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: searchTextController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Search for a Product',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: textGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onChanged: (value) {
                  setState(() {});
                  BlocProvider.of<SearchBloc>(widget.con).add(
                      SearchEventLoadData(
                          searchText: value.toString(),
                          dataList: searchedProducts));
                },
              ),
            ),
            _buildBarAction()
          ],
        ),
      ),
    );
  }

  Widget _buildBarAction() {
    if (isSearched) {
      return IconButton(
        onPressed: () {
          // TODO : X button
          widget.con.read<SearchBloc>().add(SearchEventPopSearch());
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
      );
    } else {
      return IconButton(
        onPressed: _startsearch,
        icon: const Icon(
          Icons.search_outlined,
          color: Colors.white,
        ),
      );
    }
  }

  void _startsearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    BlocProvider.of<SearchBloc>(widget.con).add(SearchEventLoadData(
        searchText: searchTextController.text, dataList: searchedProducts));

    setState(() {
      isSearched = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearched = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchTextController.clear();
      //clear data from controller
    });
  }
}

class ScreenArguments {
  final Product product;
  ScreenArguments(this.product);
}

class SendUserId {
  final String userId;
  SendUserId(this.userId);
}
