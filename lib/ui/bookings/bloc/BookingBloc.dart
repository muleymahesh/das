import 'package:das_app/objectbox.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';

import '../../../data/db/objectbox.dart';
import '../../../data/model/Booking.dart';
import 'BookingState.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {

  BookingBloc() : super(BookingsLoading()) {

    on<LoadBookings>((event, emit) async {
      emit(BookingsLoading());
      try {
        ObjectBox db  = await ObjectBox.create();
        final box = db.store.box<Booking>();
        final bookings = box.query(Booking_.type.equals("booking")).build().find();
        db.store.close();
        emit(BookingsLoaded(bookings));

      } catch (e) {
        emit(BookingError(e.toString()));
      }
    });
  }
}