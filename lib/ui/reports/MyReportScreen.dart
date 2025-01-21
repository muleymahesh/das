import 'package:das_app/ui/reports/bloc/MyReportsBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MySalesHistoryScreen.dart';


class MyReportScreen extends StatelessWidget {
  const MyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Report'),
        ),
        body: BlocProvider(
          create: (context) => MyReportsBloc()..add(FetchUserDetails()), // Add LoadBookings event
          child: BlocBuilder<MyReportsBloc, MyReportsState>(
            builder: (context, state)
            {
              if (state is UserDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserDetailsLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(

                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('₹ ${state.user.commission.toStringAsFixed(2)}', style: const TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      const SizedBox(height: 10),
                                      const Text('My Commission', textAlign: TextAlign.center,), // Replace with your number
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0), // Add spacing between cards
                          Expanded(
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Card(
                                child: SizedBox(
                                  height: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('₹ ${state.user.collection.toStringAsFixed(2)}', style: const TextStyle(
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        const Text('My Collection',
                                          ),

                                      ],
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      // Add spacing between cards and list
                      Expanded(
                        child: ListView.separated( // Use ListView.separated
                          itemCount: 1, // Number of list items
                          separatorBuilder: (context, index) =>
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            height: 16.0,
                            indent: 16.0,
                            endIndent: 16.0,
                          ),
                          itemBuilder: (context, index) {
                            final titles = [
                              'My Sales history',
                            ];
                            return Column(
                              children: [

                                ListTile(
                                  title: Text(titles[index],style: const TextStyle(
                                    fontSize: 18.0,
                                  ),),
                                  onTap: () {
                                    if (index == 0) { // Check if it's the first item
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MySalesHistoryScreen(),
                                        ),
                                      );
                                    }
                                    // Handle other list item clicks if needed
                                  },
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios), // Add right arrow
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                  height: 16.0,
                                  indent: 16.0,
                                  endIndent: 16.0,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        )

    );
  }
}