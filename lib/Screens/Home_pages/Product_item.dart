import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monirakrem/constants.dart';

import '../../models/ProductModel.dart';
import '../AppScreens/ProductDetails/ProductDetails.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.product, required this.height})
      : super(key: key);
  final Product product;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.ProductDetailsPath,
                arguments: ProductDetailArg(product));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              elevation: 1,
              child: Container(
                height: height * 0.35,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.22,
                      child: Center(
                        child: Image(
                          image: NetworkImage(product.images.first),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                        child: Text(product.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${product.price}\$',
                            style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            color: buttonColor,
            height: 80,
            width: 50,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/*
  onTap: () {
            /*
            Navigator.pushNamed(context, ProductDetails.ProductDetailsPath,
                arguments: ProductDetailArg(product));*/
          },
 */
