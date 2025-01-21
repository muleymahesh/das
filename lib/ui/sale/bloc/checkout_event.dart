part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}
  class CustomerBookingEvent extends CheckoutEvent {
    final Booking booking;
    const CustomerBookingEvent(this.booking);

  }

