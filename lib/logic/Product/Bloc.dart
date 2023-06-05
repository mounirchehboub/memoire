import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/firebasecall/ProductFirebase.dart';
import '../../models/ProductModel.dart';

part 'Event.dart';
part 'State.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitProductState()) {
    on<ProductGetEvent>(_onLoadProducts);
    on<ProductbyCategoryEvent>(_onLoadcatProducts);
  }
  ProductFirebase productFirebase = ProductFirebase();
  List<Product> Products = [];
  List<Product> categoryProduct = [];

  void _onLoadProducts(
      ProductGetEvent event, Emitter<ProductState> emit) async {
    emit(LoadProductState());

    try {
      Products = [];
      await productFirebase.getProductsData().then((productList) {
        for (var Product in productList) {
          Products.add(Product.data());
        }
      });

      emit(LoadeedProductState(products: Products));
    } catch (ex) {
      emit(FailedLoadingProductState(error: ex.toString()));
    }
  }

  void _onLoadcatProducts(
    ProductbyCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(categoryLoadingState());
    try {
      categoryProduct = [];
      await productFirebase.getProdbyCat(event.cat).then((product) {
        for (var Product in product) {
          categoryProduct.add(Product.data());
        }
      });

      emit(categoryLoadedStated(categoryProducts: categoryProduct));
    } catch (ex) {
      emit(categoryFailedLoadingState(error: ex.toString()));
    }
  }
}
