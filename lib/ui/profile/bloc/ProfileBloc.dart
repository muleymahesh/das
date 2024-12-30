import 'package:das_app/ui/profile/bloc/ProfileState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/db/objectbox.dart';
import '../../../data/model/Booking.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileBloc() : super(ProfilesLoading()) {

    on<CalculateCommission>((event, emit) async {
      emit(ProfilesLoading());
      try {
        ObjectBox db  = await ObjectBox.create();
        final box = db.store.box<Booking>();
        final bookings = box.getAll();
        db.store.close();
        int bookingCount = bookings.length;
        double commission = 0.0;
        for (var e in bookings) {
          switch(e.type){
            case "booking" : commission+=300;
           case "freshsold" : commission+=700;
            case "bookingsold" : commission+=400;
          }
        }
        final double collection = bookings.fold(0, (sum,booking) =>sum+booking.amount);
        emit(ProfilesLoaded(bookingCount,commission,collection));

      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}