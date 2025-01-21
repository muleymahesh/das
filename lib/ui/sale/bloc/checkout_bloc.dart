import 'package:bloc/bloc.dart';
import 'package:das_app/data/remote/CustomerService.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/Booking.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<CustomerBookingEvent>((event, emit) async {
      // Add logic to handle customer booking
      try {
        final productResp = await CustomerService.addCustomer(event.booking);
        // Assuming you have some booking logic here
        if (productResp.error == null) {
          // Handle successful booking response
          emit(BookingSuccess());
        } else {
          // Handle error in booking response
          emit(BookingFailure(error: productResp.error ?? "Error occurred"));
        }
        emit(BookingSuccess());
      } catch (error) {
        emit(BookingFailure(error: error.toString()));
      }
    });
  }
}
