import 'package:das_app/data/model/booking_response.dart';
import 'package:das_app/objectbox.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/db/objectbox.dart';
import '../../../data/model/Booking.dart';
import '../../../data/remote/CustomerService.dart';
import 'BookingState.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {

  BookingBloc() : super(BookingsLoading()) {

    on<LoadBookings>((event, emit) async {
      emit(BookingsLoading());
      try {
        BookingResponse response = await CustomerService.getMyBookings();
        emit(BookingsLoaded(response.bookingsList ?? []));

      } catch (e) {
        emit(BookingError(e.toString()));
      }
    });

    // on<LoadSalesHistory>((event, emit) async {
    //   emit(BookingsLoading());
    //   try {
    //     ObjectBox db  = await ObjectBox.create();
    //     final box = db.store.box<Booking>();
    //     final bookings = box.getAll();
    //     db.store.close();
    //     emit(BookingsLoaded(bookings));
    //
    //   } catch (e) {
    //     emit(BookingError(e.toString()));
    //   }
    // });

  }
}