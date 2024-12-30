// Events
import 'package:das_app/data/model/Product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final String productType;

  LoadProducts(this.productType);
}

class AddProduct extends ProductEvent {
  final Product product;

  AddProduct(this.product);
}

// States
abstract class ProductState {}

class ProductsLoading extends ProductState {
  final bool isLoading;

  ProductsLoading(this.isLoading);
}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}