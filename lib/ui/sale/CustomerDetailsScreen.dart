import 'package:das_app/data/db/objectbox.dart';
import 'package:das_app/data/model/Product.dart';
import 'package:das_app/objectbox.g.dart';
import 'package:flutter/material.dart';

import '../../data/model/Booking.dart';
import 'SaleCompleteScreen.dart';
class CustomerDetailsScreen extends StatefulWidget {
  final String productType; // Add productType property
  final Product product;
  Booking? booking;
  CustomerDetailsScreen({Key? key,required this.productType, required this.product,this.booking}) : super(key: key);

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
      _customerNameController.text = widget.booking?.customerName??"";
      _emailController.text = widget.booking?.email??"";
      _mobileNumberController.text = widget.booking?.mobileNumber??"";
      _addressController.text = widget.booking?.address??"";
      _pincodeController.text = widget.booking?.pincode??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                controller: _customerNameController, // Add controller

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
                controller: _emailController, // Add controller

                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  // Email validation using RegExp
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _mobileNumberController, // Add controller

                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  // Mobile number validation using RegExp
                  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController, // Add controller

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
                controller: _pincodeController, // Add controller

                decoration: const InputDecoration(
                  labelText: 'Pincode',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pincode';
                  }
                  // Pincode validation using RegExp
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

                      // All validations passed, navigate to SaleCompleteScreen
                      final booking = Booking(
                        customerName: _customerNameController.text,
                        email: _emailController.text,
                        mobileNumber: _mobileNumberController.text,
                        address: _addressController.text,
                        pincode: _pincodeController.text,
                        type: widget.productType,
                        amount: widget.product.price// Set type from productType
                      );
                      ObjectBox db  = await ObjectBox.create();

                      int result = db.store.box<Booking>().put(booking);
                        db.store.close();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const SaleCompleteScreen()), // Updated reference
                      );
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
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