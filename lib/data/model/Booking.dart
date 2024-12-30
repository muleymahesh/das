import 'package:objectbox/objectbox.dart';

@Entity()
class Booking {
  @Id()
  int id = 0;

  String customerName;
  String email;
  String mobileNumber;
  String address;
  String pincode;
  String type; // Add type field
  double amount; // Add type field

  Booking({
    required this.customerName,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.pincode,
    required this.type, // Add type to constructor
    required this.amount,
  });
}