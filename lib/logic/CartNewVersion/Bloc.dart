import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Services/SharedPrefrences/SharedPrefrencesService.dart';
import 'package:monirakrem/models/ProductModel.dart';
import 'package:http/http.dart' as http;

import '../../models/CartModel.dart';

part 'Event.dart';
part 'State.dart';

class CartProductBloc extends Bloc<CartProductEvent, CartProductState> {
  CartProductBloc() : super(InitialCartProductState()) {
    on<AddCartProduct>(_onAddCartProduct);
    on<RemoveCartProduct>(_onRemoveCartProduct);
    on<ResetCartProduct>(_onResetCartProduct);
    on<SubmitValidationEvent>(_onSubmitValidtion);
  }

  List<Cart> cartProducts = [];
  double TotalPrice = 0.0;
  String emailBody = '';
  bool isScotter = false;
  bool permisRequired = false;
  void _onAddCartProduct(AddCartProduct event, Emitter<CartProductState> emit) {
    try {
      emit(AddAction());
      bool isItThere = false;
      print(cartProducts);
      Cart cartItem = Cart(
          product: event.product,
          startRent: event.startRent,
          endRent: event.endRent,
          dayRnage: event.dayRange,
          hourRange: event.hourRange);
      for (var element in cartProducts) {
        if (element.product.title == event.product.title) {
          isItThere = true;
        }
      }

      if (isItThere == true) {
        emit(AlreadyExists());
      } else {
        if (event.product.category == 'Scooter' ||
            event.product.category == 'Bicycle') {
          isScotter = true;
        } else {
          permisRequired = true;
        }
        print('adding to cart');

        double productPrice = event.hourRange == 0
            ? event.product.price * event.dayRange
            : (event.product.price * event.hourRange) * event.dayRange;
        TotalPrice = TotalPrice + productPrice;
        cartProducts.add(cartItem);
        emit(LoadedCartProductState(cartProducts: cartProducts));
      }
    } catch (ex) {
      emit(FailedToLoadCartProductState(error: ex.toString()));
    }
  }

  void _onRemoveCartProduct(
      RemoveCartProduct event, Emitter<CartProductState> emit) {
    try {
      emit(RemoveAction());
      Cart cartItem = Cart(
          product: event.product,
          startRent: event.startRent,
          endRent: event.endRent,
          dayRnage: event.dayRange,
          hourRange: event.hourRange);
      double productPrice = event.hourRange == 0
          ? event.product.price * event.dayRange
          : (event.product.price * event.hourRange) * event.dayRange;
      TotalPrice = TotalPrice - productPrice;

      cartProducts.remove(cartItem);
      if (cartProducts.isEmpty) {
        print('it is empty');
        permisRequired = false;
        isScotter = false;
      }
      emit(LoadedCartProductState(cartProducts: cartProducts));
    } catch (ex) {
      emit(FailedToLoadCartProductState(error: ex.toString()));
    }
  }

  _onResetCartProduct(ResetCartProduct event, Emitter<CartProductState> emit) {
    emit(LoadingCartProductState());
    try {
      TotalPrice = 0.0;
      cartProducts = [];
      isScotter = false;
      emit(LoadedCartProductState(cartProducts: cartProducts));
    } catch (ex) {
      emit(FailedToLoadCartProductState(error: ex.toString()));
    }
  }

  _onSubmitValidtion(
      SubmitValidationEvent event, Emitter<CartProductState> emit) async {
    emit(Submitting());
    SharedPref sharedPref = await SharedPref.getInstance();

    String? userIds = await sharedPref.getUserId();
    String? firstName = await sharedPref.getFirstName();
    String? lastName = await sharedPref.getLastName();
    String? email = await sharedPref.getEmail();
    emailBody = "Command from : " +
        firstName.toString() +
        "  " +
        lastName.toString() +
        "\n" +
        "user Id :  " +
        userIds.toString() +
        "\n" +
        "email :  " +
        email.toString() +
        "\n" +
        "phone Number :  " +
        event.phoneNumber +
        "\n";

    if (permisRequired & isScotter) {
      emailBody = emailBody +
          "Driving Liscence N° :  " +
          event.permisNumber.toString() +
          "\n" +
          "Identity Cart N° :  " +
          event.cartIdNumber.toString() +
          "\n";
    } else if (permisRequired) {
      emailBody = emailBody +
          "Driving Liscence N° :  " +
          event.permisNumber.toString() +
          "\n";
    } else if (isScotter) {
      emailBody = emailBody +
          "Identity Cart N° :  " +
          event.cartIdNumber.toString() +
          "\n";
    }

    for (int i = 0; i < cartProducts.length; i++) {
      emailBody =
          "$emailBody${i + 1}   product \t${cartProducts[i].product.title}\t\nproduct Price\t${cartProducts[i].product.price}\nproduct start Time\t${cartProducts[i].startRent}\nend time\t${cartProducts[i].endRent}\nrent fees for the product \t${cartProducts[i].product.price * cartProducts[i].dayRnage}\n" +
              "\n";
    }
    emailBody =
        "----------------------------------------------------------------------------------------\n$emailBody\tTotal Price = \t$TotalPrice";

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_jhgv7fm';
    const templateId = 'template_odzf34m';
    const userId = 'PWRwPEJ_w3iV_E93M';

    try {
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json'
          }, //This line makes sure it works for all platforms.
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'from_name': firstName.toString(), // sender first name
              'from_email': email.toString(),
              'message': emailBody
            }
          }));
      if (response.statusCode == 200) {
        emit(SubmitSucssessful());
      } else {
        emit(ErrorSubmit(
            error: 'Status code ${response.statusCode} '
                'problem : ${response.body}'));
      }
    } catch (error) {
      emit(ErrorSubmit(error: error.toString()));
    }
  }
}

/*
else {
        emit(AlreadyExists());
      }
 */
