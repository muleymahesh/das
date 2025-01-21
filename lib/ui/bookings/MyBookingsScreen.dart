import 'package:das_app/data/model/Booking.dart';
import 'package:das_app/ui/product/ProductsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sale/CustomerDetailsScreen.dart';
import 'bloc/BookingBloc.dart';
import 'bloc/BookingState.dart';

class MyBookingsScreen extends StatelessWidget {
  final String from;
  const MyBookingsScreen({Key? key, required this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc()..add(LoadBookings()), // Add LoadBookings event
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(

                  itemCount: state.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = state.bookings[index];
                    return Card(
                      color: Colors.white,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                      child: Column(
                        spacing: 1,
                        children: [
                          ListTile(
                            title: Text(booking.name ?? "", style: const TextStyle(fontWeight: FontWeight.bold),),
                            onTap: (){
                              if(from.startsWith("booking")){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsScreen(productType: from,
                                      booking: Booking(id: 0,
                                          name: booking.name ?? "", email: booking.email ?? "", mobileNumber: booking.mobile ?? "", address: booking.address ?? "", pincode: booking.pincode ?? "", type: "booking", amount: 0, pId: 0, userId: 0),), // Pass productType
                                  ),
                                );

                                    }
                            },
                            subtitle: Text('${booking.email}, ${booking.mobile},\n ${booking.address}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.call),
                              onPressed: () {
                                _makePhoneCall(booking.mobile ?? "");
                              },
                            ),
                          ),
                          const Divider(height: 1,)
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (state is BookingError) {
              return Center(child: Text(state.error));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}