// Events
import '../../../data/model/Product.dart';

abstract class StockEvent {}

class LoadStock extends StockEvent {}

// States
abstract class StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<Product> products; // Assuming you have a Product model

  StockLoaded(this.products);
}

class StockError extends StockState {
  final String error;

  StockError(this.error);
}