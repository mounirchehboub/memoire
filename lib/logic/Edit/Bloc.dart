import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/firebasecall/ProductFirebase.dart';

part 'State.dart';
part 'Event.dart';

class EditBloc extends Bloc<EditProductEvent, EditProductState> {
  EditBloc() : super(InitialEditProductState()) {
    on<UpdateStockEvent>(_onUpdateStock);
    on<UpdatePromotionEvent>(_onUpdatePromotion);
    on<UpdateGeneralFieldsEvent>(_onUpdateGeneralFields);
  }

  ProductFirebase productFirebase = ProductFirebase();

  //EditBloc function to Update Stock

  Future<void> _onUpdateStock(
      UpdateStockEvent event, Emitter<EditProductState> emit) async {
    try {
      emit(LoadingStockUpdateState());
      await productFirebase.updateStock(event.uid, event.stock);
      emit(LoadedStockUpdateState());
    } catch (error) {
      emit(FailedStockUpdateState(errorMessage: error.toString()));
    }
  }

  //EditBloc function to Update Promotion
  Future<void> _onUpdatePromotion(
      UpdatePromotionEvent event, Emitter<EditProductState> emit) async {
    try {
      emit(LoadingPromotionUpdateState());
      await productFirebase.updatePromotion(
          event.uid, event.isPromotion, event.promoNumber);
      emit(LoadedPromotionUpdateState());
    } catch (error) {
      emit(FailedPromotionUpdateState(errorMessage: error.toString()));
    }
  }

  //EditBloc function to update General Fields
  Future<void> _onUpdateGeneralFields(
      UpdateGeneralFieldsEvent event, Emitter<EditProductState> emit) async {
    try {
      emit(LoadingGeneralFieldsUpdateState());
      await productFirebase.updateGeneralFields(event.data, event.uid);
      emit(LoadedGeneralFieldsUpdateState());
    } catch (error) {
      emit(FailedGeneralFieldsUpdateState(errorMessage: error.toString()));
    }
  }
}
