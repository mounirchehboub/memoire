import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/firebasecall/ProductAddStorage.dart';
import '../../Services/firebasecall/ProductFirebase.dart';
import '../../models/ProductModel.dart';
part 'State.dart';
part 'Event.dart';

class TenProductBloc extends Bloc<TenProductEvent, TenProductState> {
  TenProductBloc() : super(InitTenProductState()) {
    on<LoadTenProductEvent>(_onLoadTenProduct);
  }
  ProductFirebase productFirebase = ProductFirebase();
  List<Product> TenProd = [];

  Future<void> _onLoadTenProduct(
    TenProductEvent event,
    Emitter<TenProductState> emit,
  ) async {
    emit(LoadingTenProductState());

    try {
      TenProd = [];
      await productFirebase.getTenProducts().then((product) {
        for (var Product in product) {
          TenProd.add(Product.data());
        }
      });
      print('i am here now ');
      emit(LoadedTenProductState(TenProducts: TenProd));
    } catch (error) {
      emit(FailedLoadingTenProductState(error: error.toString()));
    }
  }
}
