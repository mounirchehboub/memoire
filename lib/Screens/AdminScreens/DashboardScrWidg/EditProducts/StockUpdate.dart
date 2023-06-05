import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monirakrem/constants.dart';

import '../../../../logic/Edit/Bloc.dart';
import '../../../../models/ProductModel.dart';
import '../AddProductAdm/DecorationScreen.dart';

class StockUpdate extends StatelessWidget {
  StockUpdate({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  static const String stockUpdatePath = '/stockUpdatePath';
  int stock = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appBackground,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: height * 0.1,
            ),
            const Text('Update your Stock ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            SizedBox(
              height: height * 0.05,
            ),
            Image.network(
              product.images.first,
              fit: BoxFit.cover,
              width: width * 0.9,
              height: height * 0.4,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                const Text(
                  'Enter new Value',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                StockTextField(
                  initial: '',
                  height: height,
                  width: width,
                  suffix: 'Pcs',
                  labelText: "stock",
                  onChanged: (value) {
                    stock = int.tryParse(value)!.toInt();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Complete Field';
                    } else if (value.contains('.')) {
                      return 'integer';
                    }
                    if (value == '0') {
                      return "invalid number";
                    }
                    return null;
                  },
                ),
              ],
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<EditBloc>(context).add(
                              UpdateStockEvent(
                                  uid: product.productId, stock: stock));
                        }
                      },
                      child: buildBlocStockUpdate(),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildBlocStockUpdate() {
    return BlocConsumer<EditBloc, EditProductState>(builder: (contexts, state) {
      if (state is LoadingStockUpdateState) {
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
      if (state is LoadedStockUpdateState) {
        Fluttertoast.showToast(
            msg: 'Updated Successfuly',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM);
        Navigator.of(context).pop();
      }
      if (state is FailedStockUpdateState) {
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
