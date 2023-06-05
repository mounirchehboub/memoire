import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Screens/AppScreens/Cart/Validation.dart';
import 'package:monirakrem/constants.dart';

import '../../../logic/CartNewVersion/Bloc.dart';
import '../../../models/CartModel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String cartPath = '/Cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    String totalPrice =
        BlocProvider.of<CartProductBloc>(context).TotalPrice.toStringAsFixed(2);
    List<Cart> cartList =
        BlocProvider.of<CartProductBloc>(context).cartProducts;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(totalPrice);
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBackground,
        title: const Text(
          'Cart',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<CartProductBloc, CartProductState>(
          buildWhen: (current, previous) => current is CartAction,
          builder: (context, state) {
            print(state);

            if (state is FailedToLoadCartProductState) {
              return Center(
                child: SingleChildScrollView(
                  child: Text(
                    state.error,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            } else {
              return cartList.length > 0
                  ? Column(
                      children: [
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: cartList.length,
                              itemBuilder: (context, idx) {
                                Cart _prd =
                                    BlocProvider.of<CartProductBloc>(context)
                                        .cartProducts[idx];
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: width * 0.22,
                                              height: width * 0.22,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.network(
                                                _prd.product.images.first,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${_prd.product.title}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${_prd.product.price} DZD',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                            Spacer(
                                              flex: 2,
                                            ),
                                            IconButton(
                                              icon: Icon(CupertinoIcons.trash,
                                                  color: Colors.red),
                                              onPressed: () => BlocProvider.of<
                                                      CartProductBloc>(context)
                                                  .add(RemoveCartProduct(
                                                      product: _prd.product,
                                                      startRent: _prd.startRent,
                                                      endRent: _prd.endRent,
                                                      dayRange: _prd.dayRnage,
                                                      hourRange:
                                                          _prd.hourRange)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                            '${(_prd.product.price * _prd.dayRnage)}'),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Spacer(),
                        Text('Total price : ${totalPrice}'),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          height: 56,
                          width: width * 0.6,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.white,
                              backgroundColor: buttonColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Validation.validationPath);
                            },
                            child: const Text(
                              'Validate Commande',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text('No Products in Cart Yet'),
                    );
            }
          }),
    );
  }
}
