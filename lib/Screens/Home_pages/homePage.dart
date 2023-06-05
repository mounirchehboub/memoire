import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Screens/AppScreens/Profile.dart';
import 'package:monirakrem/constants.dart';
import 'package:monirakrem/logic/Profile/Bloc.dart';
import 'package:provider/provider.dart';

import '../../logic/CartNewVersion/Bloc.dart';
import '../../logic/Product/Bloc.dart';
import '../../models/CartModel.dart';
import '../../models/ProductModel.dart';
import '../../models/UserModel.dart';
import 'Decorations.dart';
import 'Drawer.dart';
import 'Product_item.dart';

class ProductHome extends StatefulWidget {
  const ProductHome({
    Key? key,
  }) : super(key: key);
  @override
  _ProductHomeState createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  @override
  void dispose() {
    // TODO: implement dispose
    ProductBloc().close();
    CartProductBloc().close();
    super.dispose();
  }

  List<Product> prod = [];
  List<Product> searchedCharacters =
      []; //to store the searched characters in this list
  bool isSearched = false;
  bool isAll = true;
  final _searchTextController = TextEditingController();
  List<bool> selected = [true, false, false, false, false];
  List<Product> categoryProducts = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appBackground,
      drawer: DrawerA(
        profileBloc: context.read<ProfileBloc>(),
      ), //Drawer,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(CupertinoIcons.text_justify),
                        color: Colors.black,
                        iconSize: 32,
                      );
                    }),
                    IconButton(
                      onPressed: () {
                        //TODO go to profile page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                    value: context.read<ProfileBloc>(),
                                    child: const Profile())));
                      },
                      icon: Icon(Icons.account_circle),
                      iconSize: 32,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              _buildSearchField(),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.04),
                child: const Text(
                  'Available ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CatContianer(
                        width: width,
                        categoryText: 'All ',
                        onTap: () {
                          setState(() {
                            isAll = true;
                            selected = [true, false, false, false, false];
                          });
                          BlocProvider.of<ProductBloc>(context)
                              .add(ProductGetEvent());
                        },
                        isSelected: selected[0]),
                    CatContianer(
                      width: width,
                      categoryText: 'Car  ',
                      onTap: () {
                        setState(() {
                          isAll = false;
                          selected = [false, true, false, false, false];
                        });
                        BlocProvider.of<ProductBloc>(context).add(
                            ProductbyCategoryEvent(
                                categoryProduct: categoryProducts, cat: 'Car'));
                      },
                      isSelected: selected[1],
                    ),
                    CatContianer(
                      width: width,
                      categoryText: 'Motobike',
                      onTap: () {
                        setState(() {
                          isAll = false;
                          selected = [false, false, true, false, false];
                        });
                        BlocProvider.of<ProductBloc>(context).add(
                            ProductbyCategoryEvent(
                                categoryProduct: categoryProducts,
                                cat: 'Motorbike'));
                      },
                      isSelected: selected[2],
                    ),
                    CatContianer(
                      width: width,
                      categoryText: 'Bicycle',
                      onTap: () {
                        setState(() {
                          isAll = false;
                          selected = [false, false, false, true, false];
                        });
                        BlocProvider.of<ProductBloc>(context).add(
                            ProductbyCategoryEvent(
                                categoryProduct: categoryProducts,
                                cat: 'Bicycle'));
                      },
                      isSelected: selected[3],
                    ),
                    CatContianer(
                      width: width,
                      categoryText: 'Scooter',
                      onTap: () {
                        setState(() {
                          isAll = false;
                          selected = [false, false, false, false, true];
                        });
                        BlocProvider.of<ProductBloc>(context).add(
                            ProductbyCategoryEvent(
                                categoryProduct: categoryProducts,
                                cat: 'Scooter'));
                      },
                      isSelected: selected[4],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              isAll ? buildBlocWidget() : buildCatgoryBlocWidget()
            ],
          ),
        ),
      ),
    );
  }

  //Search Wigets

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
                controller: _searchTextController,
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
                onChanged: (searchedcharacter) {
                  addSearchedItems(searchedcharacter);
                },
              ),
            ),
            _buildBarAction()
          ],
        ),
      ),
    );
  }

  void addSearchedItems(String searched) {
    searchedCharacters = prod
        .where((product) => product.title.toLowerCase().startsWith(searched))
        .toList();
    setState(() {
      // widget to change app bar look
    });
    /*if(caca.actorName.contains(searched,0)){
    searchedCharacters = caca.actorName;
  }*/
  }

  Widget _buildBarAction() {
    if (isSearched) {
      return IconButton(
        onPressed: () {
          // TODO : X button
          _clearSearch();
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
      _searchTextController.clear();
      //clear data from controller
    });
  }

  BlocBuilder<ProductBloc, ProductState> buildCatgoryBlocWidget() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        print(state);
        if (state is categoryLoadedStated) {
          categoryProducts = state.categoryProducts;
          return categoryProducts.isNotEmpty
              ? buildLoadedListWidget()
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text('No products on this Category Yet'),
                  ),
                );
        }
        if (state is categoryFailedLoadingState) {
          return Center(
            child: Text(
              state.error,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 3.0,
          ),
        );
      },
    );
  }

  BlocBuilder<ProductBloc, ProductState> buildBlocWidget() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        print("bloc state is " + state.toString());
        if (state is LoadeedProductState) {
          prod = state.products;
          return buildLoadedListWidget();
        }
        if (state is FailedLoadingProductState) {
          return Center(
            child: Text(
              state.error,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 3.0,
          ),
        );
      },
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: buildBody(),
    );
  }

  int widgetchossing() {
    if (_searchTextController.text.isNotEmpty) {
      return searchedCharacters.length;
    } else if (isAll == false) {
      return categoryProducts.length;
    } else if (_searchTextController.text.isEmpty && isAll == true) {
      return prod.length;
    }

    return 0;
  }

  Product productselect(int index) {
    if (_searchTextController.text.isNotEmpty) {
      return searchedCharacters[index];
    } else if (isAll == false) {
      return categoryProducts[index];
    } else if (_searchTextController.text.isEmpty && isAll == true) {
      return prod[index];
    }

    return prod[index];
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widgetchossing(),
          itemBuilder: (context, i) {
            String userId = Provider.of<Users>(context).Uuid;

            return ProductItem(
              product: productselect(i),
              height: MediaQuery.of(context).size.height,
            );
          }),
    );
  }
}

/*
              row: Row(children: [
                IconButton(
                    icon: Icon(
                      CupertinoIcons.shopping_cart,
                      color: BlocProvider.of<CartProductBloc>(context)
                              .cartProducts
                              .where((element) {
                        if (element.product.productId == prod[i].productId) {
                          return true;
                        }
                        return false;
                      }).isNotEmpty
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onPressed: () => BlocProvider.of<CartProductBloc>(context)
                            .add(AddCartProduct(
                                cartProduct: Cart(
                          product: prod[i],
                          numOfItem: 0,
                        )))),
                IconButton(
                    icon: Icon(
                      CupertinoIcons.heart_fill,
                      color:
                          FavProductBloc(userId).isThere(prod[i].productId) ==
                                  true
                              ? Colors.red
                              : Colors.grey,
                    ),
                    onPressed: () {
                      BlocProvider.of<FavProductBloc>(context)
                          .add(ProductToggleFavoriteEvent(product: prod[i]));
                    }),
              ]),

 */

/*
  @override
  void initState() {
    void postFrame(void Function() callback) =>
        WidgetsBinding.instance?.addPostFrameCallback(
          (_) {
            // Execute callback if page is mounted
// TODO: implement initState
            final user = Provider.of<Users>(context);
            context
                .read<ProfileBloc>()
                .add(LoadProfileEvent(ProfileId: user.Uuid));
          },
        );

    super.initState();
  }
 */
