import 'package:das_app/data/db/objectbox.dart';
import 'package:das_app/data/model/Product.dart';
import 'package:das_app/data/model/product_response.dart';
import 'package:das_app/data/model/user.dart';
import 'package:das_app/data/remote/ProductService.dart';
import 'package:das_app/ui/product/bloc/ProductState.dart';
import 'package:das_app/utils/StorageUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductBloc() : super(ProductsLoading(false)) {

    on<LoadProducts>((event, emit) async {
      emit(ProductsLoading(true));
      try {

        final productResp = await ProductService.getProducts((await StorageUtils.getUser()).username);
        if(event.productType.endsWith("booking")) {
          emit(ProductsLoaded(productResp.productsList?.where((element) => element.sKU == "PL").toList() ?? []));
        }else if(event.productType.startsWith("fresh")) {
          emit(ProductsLoaded(productResp.productsList?.where((element) => element.sKU != "PL").toList() ?? []));
        } else if(event.productType.startsWith("addstock")) {
          List<Products> data = productResp.productsList?.map((product) => product..quantity="0").toList() ?? [];
          emit(ProductsLoaded(data));

        } else{
          emit(ProductsLoaded(productResp.productsList??[]));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      } finally {
        //emit(ProductsLoading(false));
      }
    });

    on<GetAllStock>((event, emit) async {
      emit(ProductsLoading(true));
      try {
        final stockResp = await ProductService.getAllProducts();
        emit(AllProductsLoaded(stockResp.dataListList ?? []));
      } catch (e) {
        emit(ProductError(e.toString()));
      } finally {
       // emit(ProductsLoading(false));
      }
    });

    on<RequestStock>((event, emit) async {
      try{
        emit(ProductsLoading(true));
        User u = (await StorageUtils.getUser());
        await ProductService.requestStock(u.username,u.supervisor_id,event.products);

        emit(ProductsLoading(false));
        emit(RequestSuccess());
      }
      catch(e){
        emit(ProductError(e.toString()));
      }


    });
  }



}