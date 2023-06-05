part of 'Bloc.dart';

abstract class TenProductEvent {
  const TenProductEvent();
}

class LoadTenProductEvent extends TenProductEvent {
  final List<Product> TenProducts;
  LoadTenProductEvent({required this.TenProducts});
}
