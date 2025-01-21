import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/ProductBloc.dart';
import 'bloc/ProductState.dart';

class StockRequestPage extends StatelessWidget {
  const StockRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetAllStock()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stock Request'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AllProductsLoaded) {

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        final TextEditingController quantityController = TextEditingController();
                        quantityController.addListener(() {
                          if (quantityController.text.isNotEmpty) {
                            state.products[index].quantity = quantityController.text;
                          }
                        });
                        quantityController.text = product.quantity ?? '';
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.white,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text('${product.sKU} | ${product.name ?? ""}'),
                            trailing: SizedBox(
                              width: 150,
                              child: TextField(
                                controller: quantityController,
                                decoration: const InputDecoration(
                                  labelText: 'Enter quantity',
                                  border: OutlineInputBorder(
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),

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
                          context.read<ProductBloc>().add(RequestStock(state.products));
                        }
                        , child: const Text("Request stock",style: TextStyle(color: Colors.white),)),
                  ),
                  const SizedBox(height: 16,)

                ],
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.error));
            }
            else if(state is RequestSuccess){
              return const Center(child: Text("Stock request sent successfully"));
            }
            else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}