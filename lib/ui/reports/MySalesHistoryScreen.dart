// lib/ui/reports/MySalesHistoryScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/SalesHistoryBloc.dart';
import 'bloc/SalesHistoryEvent.dart';
import 'bloc/SalesHistoryState.dart';

class MySalesHistoryScreen extends StatelessWidget {
  const MySalesHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesHistoryBloc()..add(LoadSalesHistory()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Sales History'),
        ),
        body: BlocBuilder<SalesHistoryBloc, SalesHistoryState>(
          builder: (context, state) {
            if (state is SalesHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SalesHistoryLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: state.salesHistory.length,
                  itemBuilder: (context, index) {
                    final salesHistory = state.salesHistory[index];
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        title: Text(salesHistory.productName),
                        subtitle: Text('Quantity: ${salesHistory.quantity}'),
                        trailing: Text('\$${salesHistory.totalPrice}'),
                      ),
                    );
                  },
                ),
              );
            } else if (state is SalesHistoryError) {
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