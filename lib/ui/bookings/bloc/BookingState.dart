// Events
import '../../../data/model/Booking.dart';

abstract class BookingEvent {}

class LoadBookings extends BookingEvent {}

// States
abstract class BookingState {}

class BookingsLoading extends BookingState {}

class BookingsLoaded extends BookingState {
  final List<Booking> bookings;

  BookingsLoaded(this.bookings);
}

class BookingError extends BookingState {
  final String error;

  BookingError(this.error);
}