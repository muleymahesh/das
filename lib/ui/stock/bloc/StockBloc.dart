import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';

import '../../../data/model/Product.dart';
import 'StockState.dart';


class StockBloc extends Bloc<StockEvent, StockState> {


  StockBloc() : super(StockLoading()) {
    on<LoadStock>((event, emit) async {
      emit(StockLoading());
      try {
        // final box = store.box<Product>();
        final products = stubProducts();
        emit(StockLoaded(products));
      } catch (e) {
        emit(StockError(e.toString()));
      }
    });
  }
  List<Product> stubProducts(){
    return  [
      Product(1, "RD", 2699, 10, "type"),
      Product(1, "GD", 2699, 10, "type"),
      Product(1, "CD", 2699, 10, "type"),
      Product(1, "BCD", 2699, 10, "type"),
      Product(1, "RDZ+", 2699, 10, "type"),
      Product(1, "PD", 2699, 10, "type"),
    ];
  }
}