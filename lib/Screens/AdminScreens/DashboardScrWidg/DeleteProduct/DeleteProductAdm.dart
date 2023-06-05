import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monirakrem/constants.dart';

import '../../../../Services/firebasecall/ProductFirebase.dart';
import '../../../../logic/LoadTen/Bloc.dart';
import '../../../../logic/Search/Bloc.dart';
import '../../../../logic/newProduct/Bloc.dart';
import '../../../../models/ProductModel.dart';

class DeleteProductAdm extends StatefulWidget {
  const DeleteProductAdm({Key? key}) : super(key: key);
  static const String DeleteProductAdmPath = "/DeleteProductAdmPath";

  @override
  _DeleteProductAdmState createState() => _DeleteProductAdmState();
}

class _DeleteProductAdmState extends State<DeleteProductAdm> {
  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  bool isSearched = false;
  List<Product> searchedProducts = [];
  TextEditingController searchTextController = TextEditingController();
  ProductFirebase productFirebase = ProductFirebase();
  List<Product> LoadedProducts = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Widget space = SizedBox(
      height: height * 0.04,
    );

    return Scaffold(
      backgroundColor: appBackground,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.08,
              ),
              const Center(
                child: Text(
                  'Delete Products',
                  style: TextStyle(color: Color(0xFF444444), fontSize: 25),
                ),
              ),
              space,
              _buildSearchField(),
              space,
              searchTextController.text.isNotEmpty
                  ? buildBlocBuilderSearched(height, width, context)
                  : buildBlocWidget(height, width, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget blocWidgetDelete() {
    return BlocConsumer<ProduitBloc, ProduitState>(
      listener: (contexts, state) {
        print("state is inside Listener" + state.toString());
        if (state is LoadedDeletingState) {
          Fluttertoast.showToast(
              msg: "Product was Successfuly Deleted",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);
          Navigator.pop(context);
        }
        if (state is FailedDeletingState) {
          Fluttertoast.showToast(
              msg: state.error.toString(),
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);
          Navigator.pop(context);
        }
      },
      builder: (contexts, state) {
        print("state is inside BUILDER " + state.toString());
        if (state is LoadingDeletingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (state is LoadedDeletingState) {
          return const Text(
            'Delete',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          );
        }
        return const Text(
          'Delete',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
      },
    );
  }

  //ShowAlertDialog
  Future showDialogs(String uid, BuildContext contextA) {
    return showDialog(
      context: contextA,
      builder: (_) {
        return BlocProvider.value(
          value: contextA.read<ProduitBloc>(),
          child: AlertDialog(
            icon: const Icon(
              CupertinoIcons.delete,
              color: Colors.red,
              size: 80,
            ),
            title: const Text(
              "You are about to delete a product",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "This will delete your product from catalog \nAre you sure ?",
              style: TextStyle(fontWeight: FontWeight.bold, color: textGrey),
            ),
            actions: <Widget>[
              Container(
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  child: blocWidgetDelete(),
                  onPressed: () {
                    BlocProvider.of<ProduitBloc>(contextA)
                        .add(DeleteEvent(uid: uid));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BlocBuilder<TenProductBloc, TenProductState> buildBlocWidget(
      double height, double width, BuildContext con) {
    return BlocBuilder<TenProductBloc, TenProductState>(
      builder: (context, state) {
        print("bloc state is " + state.toString());
        if (state is LoadedTenProductState) {
          LoadedProducts = state.TenProducts;
          return buildLoadedListWidget(height, width, con);
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

  Widget buildLoadedListWidget(double height, double width, BuildContext cont) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: searchTextController.text.isNotEmpty
              ? searchedProducts.length
              : LoadedProducts.length,
          itemBuilder: (contexts, index) {
            return InkWell(
              child: Container(
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: height * 0.02),
                height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                  color: buttonGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                    Spacer(),
                    IconButton(
                      icon:
                          const Icon(CupertinoIcons.delete, color: Colors.red),
                      onPressed: () {
                        String id = searchTextController.text.isNotEmpty
                            ? searchedProducts[index].productId
                            : LoadedProducts[index].productId;
                        showDialogs(id, cont);
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  //Widget to buildSearched Products to the Ui
  Widget buildBlocBuilderSearched(
      double height, double width, BuildContext contextA) {
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
        return buildLoadedListWidget(height, width, contextA);
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
                style: TextStyle(color: Colors.white, fontSize: 18),
                onChanged: (value) {
                  setState(() {});
                  BlocProvider.of<SearchBloc>(context).add(SearchEventLoadData(
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
          context.read<SearchBloc>().add(SearchEventPopSearch());
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
    BlocProvider.of<SearchBloc>(context).add(SearchEventLoadData(
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
