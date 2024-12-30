import 'package:das_app/data/model/Product.dart';
import 'package:das_app/ui/product/bloc/ProductState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:realm/realm.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductBloc() : super(ProductsLoading(false)) {

    on<LoadProducts>((event, emit) async {
      emit(ProductsLoading(true));
      try {
        // final products = realm.all<Product>().toList();
        // emit(ProductsLoaded(products));
        if(event.productType.endsWith("booking"))
          emit(ProductsLoaded(stubProductspl()));
        else
          emit(ProductsLoaded(stubProducts()));
      } catch (e) {
        emit(ProductError(e.toString()));
      } finally {
        //emit(ProductsLoading(false));
      }
    });

    on<AddProduct>((event, emit) {
      // realm.write(() {
      //   realm.add(event.product);
      // });
    });
  }

  List<Product> stubProducts(){
    return  [
      Product(1, "RD", 2699, 10, "type"),
      Product(1, "GD", 2699, 10, "type"),
      Product(1, "CD", 2699, 10, "type"),
      Product(1, "BCD", 2699, 10, "type"),
      Product(1, "RDZ+", 2699, 10, "type"),
      Product(1, "P", 2699, 10, "type"),
    ];
  }

  List<Product> stubProductspl(){
    return  [

      Product(1, "PL", 500, 10, "type"),
    ];
  }
}