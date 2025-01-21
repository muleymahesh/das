import 'package:objectbox/objectbox.dart';

class Booking {

  int id = 0;
  String name;
  String email;
  String mobileNumber;
  String address;
  String pincode;
  String type; // Add type field
  double amount; // Add type field
  int pId;
  int userId;
  Booking({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.pincode,
    required this.type,
    required this.amount,
    required this.pId,
    required this.userId,
  });
}