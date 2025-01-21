import 'package:das_app/ui/product/bloc/ProductBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'StockRequestPage.dart';
import 'bloc/ProductState.dart';


class MyStockScreen extends StatelessWidget {
  const MyStockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProducts("stock")),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Stock'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return Card(
                          color: Colors.white,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('${product.sKU} | ${product.name ??""}'), // Assuming your Product model has a name property
                                trailing: Text('Stock: ${product.quantity}',style: const TextStyle(fontSize: 16),), // Assuming your Product model has a stock property
                              ),
                              Container(
                                height: 1.0,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,

                                ),
                              )
                            ],
                          ),
                        );

                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const StockRequestPage()),
                          );
                        }, child: const Text("Raise stock request",style: TextStyle(color: Colors.white),)),
                  ),
              SizedBox(height: 16,)
                ],
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.error ?? 'An error occurred'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}