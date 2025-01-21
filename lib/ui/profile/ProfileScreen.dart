import 'package:das_app/ui/profile/bloc/ProfileBloc.dart';
import 'package:das_app/ui/profile/bloc/ProfileState.dart';
import 'package:das_app/ui/product/MyStockScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bookings/MyBookingsScreen.dart';
import '../collection/MyCollectionScreen.dart';
import '../reports/MyReportScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc()..add(GetUserData()), // Add LoadBookings event
        child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state)
    {
      if (state is ProfilesLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ProfilesLoaded) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Text('Hello ${state.}',
              //   style: TextStyle(
              //     fontSize: 21.0,
              //     fontWeight: FontWeight.bold,
              //   ),),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                        Text('₹ ${state.commission.toStringAsFixed(2)}', style: const TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(height: 10),
                            const Text('My Commission'), // Replace with your number
                          ],
                        ),
                      ),
                    ),
                  ),
                 const SizedBox(width: 16.0), // Add spacing between cards
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyReportScreen()),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                             Text('My Reports',
                               style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text(''), // Replace with your number
                            ],
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
                  itemCount: 3, // Number of list items
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
                      'My Bookings',
                      'Deposit Collection',
                      'manage Stock',
                    ];
                    return ListTile(
                      title: Text(titles[index]),
                      onTap: () {
                        if (index == 0) { // Check if it's the first item
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyBookingsScreen(from:"profile", ),
                            ),
                          );
                        }
                        if (index == 1) { // Assuming "My Collection" is the third item
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyCollectionScreen(),
                            ),
                          );
                        }
                        if (index == 2) { // Assuming "Manage Stock" is the fourth item
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyStockScreen()),
                          );
                        }
                        // Handle other list item clicks if needed
                      },
                      trailing: const Icon(
                          Icons.arrow_forward_ios), // Add right arrow
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
    );
  }
}