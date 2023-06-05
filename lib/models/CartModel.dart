import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'ProductModel.dart';

class Cart extends Equatable {
  final Product product;
  String startRent;
  String endRent;
  final int dayRnage;
  int hourRange;

  Cart(
      {required this.product,
      required this.startRent,
      required this.endRent,
      required this.dayRnage,
      this.hourRange = 0});

  @override
  List<Object> get props => [product, startRent, endRent];
}

// Demo data for our cart
