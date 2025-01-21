// Events
import 'package:das_app/data/model/booking_response.dart';


abstract class BookingEvent {}

class LoadBookings extends BookingEvent {}
class LoadSalesHistory extends BookingEvent {}

// States
abstract class BookingState {}

class BookingsLoading extends BookingState {}

class BookingsLoaded extends BookingState {
  final List<Bookings> bookings;

  BookingsLoaded(this.bookings);
}

class BookingError extends BookingState {
  final String error;

  BookingError(this.error);
}