// Events

import 'package:das_app/data/model/all_products_response.dart';
import 'package:das_app/data/model/product_response.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final String productType;

  LoadProducts(this.productType);
}

class AddProduct extends ProductEvent {
  final Products product;

  AddProduct(this.product);
}

class RequestStock extends ProductEvent {
  final List<DataList> products;
  RequestStock(this.products);
}
class GetAllStock extends ProductEvent {}
// States
abstract class ProductState {}

class ProductsLoading extends ProductState {
  final bool isLoading;

  ProductsLoading(this.isLoading);
}
class RequestSuccess extends ProductState {}
class ProductsLoaded extends ProductState {
  final List<Products> products;


  ProductsLoaded(this.products);
}
class AllProductsLoaded extends ProductState {
  final List<DataList> products;


  AllProductsLoaded(this.products);
}
class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}