import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/firebasecall/ProductAddStorage.dart';
import '../../Services/firebasecall/ProductFirebase.dart';
import '../../models/ProductModel.dart';
part 'Event.dart';
part 'State.dart';

class ProduitBloc extends Bloc<ProduitEvent, ProduitState> {
  ProduitBloc() : super(InitProduitState()) {
    on<ProduitAddEvent>(_onAddProduit);
    on<ProductbyTitleEvent>(_onLoadTitleProducts);
    on<DeleteEvent>(_onDeleteProduit);
  }
  List<Product> titleProducts = [];
  ProductFirebase productFirebase = ProductFirebase();
  ProductStorage productStorage = ProductStorage();
  Future<void> _onAddProduit(
    ProduitAddEvent event,
    Emitter<ProduitState> emit,
  ) async {
    try {
      emit(LoadingProduitState());
      await productFirebase.addProduct(event.product);
      emit(LoadedProduitState());
    } catch (error) {
      emit(FailedLoadingProduitState(error: error.toString()));
    }
  }

  void _onLoadTitleProducts(
    ProductbyTitleEvent event,
    Emitter<ProduitState> emit,
  ) async {
    emit(LoadingTtileProduitState());
    try {
      titleProducts = [];
      await productFirebase.getProdbyCat(event.title).then((product) {
        for (var Product in product) {
          titleProducts.add(Product.data());
        }
      });

      emit(LoadedTitleProduitState(titleProducts: titleProducts));
    } catch (ex) {
      emit(FailedLoadingTitleProduitState(error: ex.toString()));
    }
  }

  void _onDeleteProduit(
    DeleteEvent event,
    Emitter<ProduitState> emit,
  ) async {
    emit(LoadingDeletingState());

    try {
      await productFirebase.DeleteProduct(event.uid);

      emit(LoadedDeletingState());
    } catch (error) {
      emit(FailedDeletingState(error: error.toString()));
    }
  }
}
