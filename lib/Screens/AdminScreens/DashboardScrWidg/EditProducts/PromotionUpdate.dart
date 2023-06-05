import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monirakrem/constants.dart';

import '../../../../logic/Edit/Bloc.dart';
import '../../../../models/ProductModel.dart';
import '../AddProductAdm/DecorationScreen.dart';
import '../AddProductAdm/RadioRow.dart';

class PromotionUpdate extends StatefulWidget {
  PromotionUpdate({Key? key, required this.product}) : super(key: key);
  static const String promotionUpdatePath = '/promotionUpdatePath';
  final Product product;

  @override
  State<PromotionUpdate> createState() => _PromotionUpdateState();
}

class _PromotionUpdateState extends State<PromotionUpdate> {
  int isPromotion = 2;
  int Promotion = 0;
  double newPrice = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    calculatenewPrice(int promoValue) {
      setState(() {
        double X = (promoValue.toDouble() * widget.product.price) / 100;
        newPrice = widget.product.price - X;
      });
    }

    setSelectedPromotion(int? value) {
      setState(() {
        isPromotion = value!;
        if (isPromotion == 2) {
          Promotion = 0;
        }
      });
    }

    return Scaffold(
      backgroundColor: appBackground,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.10,
              ),
              Stack(
                children: [
                  Container(
                    width: width * 0.9,
                    height: height * 0.4,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.product.images.first,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Promotion != 0
                      ? Positioned(
                          top: height * 0.02,
                          right: height * 0.02,
                          child: Container(
                            width: width * 0.25,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red),
                            child: Center(
                              child: Text(
                                '-  $Promotion %',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                      : Container(),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Price :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Text(
                      '${widget.product.price.toString()} \$',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.04),
              Promotion != 0
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'New Price :   ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          Text(
                            '${newPrice.toStringAsFixed(2)} \$',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(height: height * 0.04),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: RowRadioButton(
                  width: width,
                  selectedNew: isPromotion,
                  text: "Promotion  ",
                  onChanged: (val) {
                    setSelectedPromotion(val);
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              isPromotion == 1
                  ? Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: suffTextField(
                          initial: '',
                          onChanged: (value) {
                            setState(() {
                              if (value == '' || value == null) {
                                Promotion = 0;
                              }
                              Promotion = int.tryParse(value)!.toInt();
                            });
                            calculatenewPrice(int.tryParse(value)!.toInt());
                          },
                          height: height,
                          width: width,
                          suffix: '%',
                          labelText: 'Promotion',
                          isInteger: true,
                        ),
                      ),
                    )
                  : Container(
                      height: height * 0.07,
                    ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: width * 0.3,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Container(
                      width: width * 0.3,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepOrange),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              if (isPromotion == 2) {
                                Promotion = 0;
                              }
                            });
                            BlocProvider.of<EditBloc>(context).add(
                                UpdatePromotionEvent(
                                    uid: widget.product.productId,
                                    isPromotion: changeToBool(isPromotion),
                                    promoNumber: Promotion));
                          }
                        },
                        child: blocConsumer(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool changeToBool(int number) {
    if (number == 1) {
      return true;
    }
    return false;
  }

  Widget blocConsumer() {
    return BlocConsumer<EditBloc, EditProductState>(builder: (context, state) {
      if (state is LoadingPromotionUpdateState) {
        return const Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ));
      }
      return const Text(
        'Update',
        style: TextStyle(color: Colors.white),
      );
    }, listener: (context, state) {
      if (state is LoadedPromotionUpdateState) {
        Fluttertoast.showToast(
            msg: 'Updated Successfuly',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM);
        Navigator.of(context).pop();
      }
      if (state is FailedPromotionUpdateState) {
        Fluttertoast.showToast(
            msg: state.errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM);
      }
    });
  }
}
