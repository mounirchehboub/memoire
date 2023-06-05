part of 'Bloc.dart';

abstract class EditProductEvent {
  const EditProductEvent();
}

class UpdatePromotionEvent extends EditProductEvent {
  final String uid;
  final bool isPromotion;
  final int promoNumber;
  UpdatePromotionEvent({
    required this.uid,
    required this.isPromotion,
    required this.promoNumber,
  });
}

class UpdateStockEvent extends EditProductEvent {
  final String uid;
  final int stock;

  UpdateStockEvent({required this.uid, required this.stock});
}

class UpdateGeneralFieldsEvent extends EditProductEvent {
  final String uid;
  final Map<String, dynamic> data;

  UpdateGeneralFieldsEvent({required this.uid, required this.data});
}
