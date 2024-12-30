import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/StockBloc.dart';
import 'bloc/StockState.dart';


class MyStockScreen extends StatelessWidget {
  const MyStockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc()..add(LoadStock()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Stock'),
        ),
        body: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            if (state is StockLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StockLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(product.name), // Assuming your Product model has a name property
                              trailing: Text('Stock: ${product.stock}'), // Assuming your Product model has a stock property
                            ),
                            Container(
                              height: 1.0,
                              decoration: const BoxDecoration(
                                color: Colors.grey,

                              ),
                            )
                          ],
                        );

                      },
                    ),
                  ),
                  ElevatedButton(onPressed: (){}, child: Text("Raise stock request"))
                ],
              );
            } else if (state is StockError) {
              return Center(child: Text(state.error));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}