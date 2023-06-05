import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/constants.dart';
import 'package:monirakrem/logic/CartNewVersion/Bloc.dart';

import '../../../models/ProductModel.dart';
import 'composent/ImagePr.dart';
import 'composent/customappbar.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.product}) : super(key: key);
  final Product product;
  static const String ProductDetailsPath = '/ProductDetailsPath';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime startDateTime = DateTime.now();
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  int rangeTime = 1;
  bool showError = true;

  _selectDateRange(BuildContext ctx) async {
    final DateTimeRange? range = await showDateRangePicker(
        context: ctx, firstDate: DateTime.now(), lastDate: DateTime(2028));
    if (range != null) {
      setState(() {
        dateTimeRange = range;
        rangeTime = dateTimeRange.duration.inDays;
        showError = false;
      });
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext contexts) {
    double height = MediaQuery.of(contexts).size.height;
    double width = MediaQuery.of(contexts).size.width;

    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
            left: width * 0.25,
            right: width * 0.15,
            bottom: 20,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                primary: Colors.white,
                backgroundColor: buttonColor,
              ),
              onPressed: () {
                showError == false
                    ? contexts.read<CartProductBloc>().add(AddCartProduct(
                        product: widget.product,
                        startRent:
                            '${dateTimeRange.start.year} - ${dateTimeRange.start.month} - ${dateTimeRange.start.day}',
                        endRent:
                            '${dateTimeRange.end.year} - ${dateTimeRange.end.month} - ${dateTimeRange.end.day}',
                        dayRange: rangeTime))
                    : print('noting');
              },
              child: cartConsummer(contexts),
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(rating: widget.product.rating),
        ),
        backgroundColor: appBackground,
        body: ListView(
          children: [
            ProductImages(product: widget.product),
            SizedBox(
              height: height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Text(
                        '${widget.product.price.toString()}\$',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width * 0.9,
                    child: Text(
                      widget.product.description,
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                _selectDateRange(contexts);
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                primary: Colors.white,
                                backgroundColor: buttonColor,
                              ),
                              child: const Text('Select date range'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: showError
                                  ? Text(
                                      'Select rangeTime',
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 13,
                                          color: Colors.red[700],
                                          height: 0.5),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                      'start day ${dateTimeRange.start.year} - ${dateTimeRange.start.month} - ${dateTimeRange.start.day} '),
                  Text(
                      'last day ${dateTimeRange.end.year} - ${dateTimeRange.end.month} - ${dateTimeRange.end.day} '),
                ],
              ),
            ),
          ],
        ));
  }

  Widget cartConsummer(BuildContext contexts) {
    return BlocConsumer<CartProductBloc, CartProductState>(
        bloc: contexts.read<CartProductBloc>(),
        builder: (context, state) {
          print(state);
          if (state is AddAction) {
            return const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            );
          }
          return const Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          );
        },
        listener: (context, state) {
          print(state);
          if (state is LoadedCartProductState) {
            showToast('Product Added Sucssessfully ', Colors.green);
          }
          if (state is AlreadyExists) {
            showToast('Alreeaddy', Colors.purple);
          }
          if (state is FailedToLoadCartProductState) {
            showToast(state.error, Colors.red);
          }
        });
  }
}

class ProductDetailArg {
  final Product product;
  ProductDetailArg(this.product);
}
