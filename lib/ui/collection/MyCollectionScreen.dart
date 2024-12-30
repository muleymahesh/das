import 'package:das_app/data/model/Deposition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/db/objectbox.dart';
import 'bloc/DepositionBloc.dart';
import 'bloc/DepositionState.dart';

class MyCollectionScreen extends StatelessWidget {
  double collection;
  MyCollectionScreen({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepositionBloc()..add(LoadDepositions()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Collection'),
        ),
        body: BlocBuilder<DepositionBloc, DepositionState>(
          builder: (context, state) {
            if (state is DepositionsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DepositionsLoaded) {

              return Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Collection: ₹ ${collection.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(

                      itemCount: state.depositions.length,
                      itemBuilder: (context, index) {
                        final deposition = state.depositions[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('raised request for ₹ ${deposition.amount.toStringAsFixed(2)}'),
                                subtitle: Text(
                                  'Date: ${DateFormat('dd/MM/yyyy').format(deposition.date)}'
                                      '  Assigned To: ${deposition.assignedTo}'
                                      '\nstatus: pending',
                                ),
                              ),
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
                  SizedBox(
                      width: double.infinity, // Make button width match parent
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Colors.blue,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Set font size here
                        ),
                        onPressed: () async {
                          // Show dialog instead of navigating to CreateDepositionScreen
                          Deposition d = Deposition(amount: 10000.00, date: DateTime.now(), raisedBy: "mahesh", assignedTo: "Amol");
                          BlocProvider.of<DepositionBloc>(context).add(SubmitDepositions(d));
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Deposition Created'),
                                content: const Text('Deposition created successfully!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Deposit now"),
                      )
                  ),
                  Divider(height: 16,)
                ],
              );
            } else if (state is DepositionError) {
              return Center(child: Text(state.error));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
  void _showRaiseStockRequestDialog(BuildContext context, ) {
    final _formKey = GlobalKey<FormState>();
    final _qtyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Raise Deposition Request'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Amount';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save stock request to ObjectBox
                  // ...

                  Navigator.of(context).pop();
                  // Optionally show a success message
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}