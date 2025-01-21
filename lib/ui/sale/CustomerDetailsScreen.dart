import 'package:das_app/data/model/product_response.dart';
import 'package:das_app/data/model/user.dart';
import 'package:das_app/utils/StorageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/Booking.dart';
import 'SaleCompleteScreen.dart';
import 'bloc/checkout_bloc.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final String productType; // Add productType property
  final Products product;
  Booking? booking;
  CustomerDetailsScreen({super.key,required this.productType, required this.product,this.booking});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
// Controllers for TextFormFields
  final _customerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();


  @override
  void initState() {
    if(widget.booking!=null){
      _customerNameController.text = widget.booking?.name??"";
      _emailController.text = widget.booking?.email??"";
      _mobileNumberController.text = widget.booking?.mobileNumber??"";
      _addressController.text = widget.booking?.address??"";
      _pincodeController.text = widget.booking?.pincode??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
  create: (context) => CheckoutBloc(),
  child: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SaleCompleteScreen(
                  booking: widget.booking!,
                  product: widget.product,
                ),
              ),
            );
          } else if (state is BookingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Customer Details'),
              backgroundColor: Colors.blue,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Customer Details',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _customerNameController,
                        decoration: const InputDecoration(
                          labelText: 'Customer Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _mobileNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mobile number';
                          }
                          if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _pincodeController,
                        decoration: const InputDecoration(
                          labelText: 'Pincode',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pincode';
                          }
                          if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                            return 'Please enter a valid 6-digit pincode';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User user = await StorageUtils.getUser();

                              widget.booking = Booking(
                                name: _customerNameController.text,
                                email: _emailController.text,
                                mobileNumber: _mobileNumberController.text,
                                address: _addressController.text,
                                pincode: _pincodeController.text,
                                type: widget.productType,
                                amount: double.parse(
                                    widget.product.price ?? "0.0"),
                                pId: int.parse(widget.product.id ?? "0"),
                                userId: int.parse(user.username ?? ""),
                                id: 0,
                              );
                              context.read<CheckoutBloc>().add(
                                  CustomerBookingEvent(widget.booking!));
                            }
                          },
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
            ),
          );
        }
    ),
);

}
  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _customerNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();

    super.dispose();
  }
}