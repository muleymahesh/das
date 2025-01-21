import 'dart:convert';

import 'package:das_app/data/model/CommonResponse.dart';
import 'package:das_app/data/model/booking_response.dart';
import 'package:das_app/data/model/deposition_response.dart';
import 'package:das_app/ui/profile/bloc/ProfileState.dart';
import 'package:das_app/utils/StorageUtils.dart';

import '../model/Booking.dart';
import '../model/LoginResponse.dart';
import 'package:http/http.dart' as http;

import '../model/SalesHistory.dart';

class CustomerService {
  static Future<LoginResponse> addCustomer(Booking booking) async {
    final response = await http.post(
      Uri.parse('http://das.makslab.com/api.php'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'customerName': booking.name,
        'email': booking.email,
        'mobileNumber': booking.mobileNumber,
        'address': booking.address,
        'pincode': booking.pincode,
        'type' : booking.type,
        'amount' : booking.amount.toString(),
        'pId' : booking.pId.toString(),
        'userId' : booking.userId.toString(),
        'method': 'addCustomer',
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return LoginResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Customer.');
    }
  }

      static Future<BookingResponse> getMyBookings() async {
        final response = await http.post(
          Uri.parse('http://das.makslab.com/api.php'),

          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{

            'user_id' : (await StorageUtils.getUser()).username,
            'method': 'myBookings',
          }),
        );
        if (response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          return BookingResponse.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>);
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to create Customer.');
        }
      }
  static Future<List<SalesHistory>> getSalesHistory() async {

    final response = await http.post(
      Uri.parse('http://das.makslab.com/api.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': (await StorageUtils.getUser()).username,
        'method': 'salesHistory',
      }));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => SalesHistory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sales history');
    }
  }
  static Future<CommonResponse> depositCollection(String userId,int supervisorId, double amount) async {
    final response = await http.post(
      Uri.parse('http://das.makslab.com/api.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': '$userId',
        'supervisorId': '$supervisorId',
        'amount': amount.toString(),
        'method': 'depositCollection',
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return CommonResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Customer.');
    }
  }

  static Future<DepositionResponse> fetchDepositionRequests(String userId,int supervisorId, double amount) async {
    final response = await http.post(
      Uri.parse('http://das.makslab.com/api.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': '$userId',
        'method': 'myDepositionRequest',
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return DepositionResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Customer.');
    }
  }

}