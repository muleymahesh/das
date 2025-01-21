import 'package:das_app/data/remote/LoginService.dart';
import 'package:das_app/ui/profile/bloc/ProfileState.dart';
import 'package:das_app/utils/StorageUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/db/objectbox.dart';
import '../../../data/model/Booking.dart';
import '../../../data/model/user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileBloc() : super(ProfilesLoading()) {

    on<GetUserData>((event, emit) async {
      emit(ProfilesLoading());
      try {
        // Replace with your login logic
        final loginResponse = await LoginService.getUser((await StorageUtils.getUser()).username);
        if(loginResponse.error != null) {
          emit(ProfileError(loginResponse.error ?? ''));
          return;
        }
        ObjectBox db  = await ObjectBox.create();
        final box = db.store.box<User>();
        box.removeAll();
        if(box.isEmpty()) {
          box.put(
              User(
                  name: loginResponse?.user?.name ?? "",
                  username: loginResponse.user?.userId ?? "",
                  mobile: loginResponse.user?.mobile ?? "",
                  type: loginResponse.user?.role ?? "",
                  commission: double.parse(loginResponse.user?.commission ?? ""),
                  collection: double.parse(loginResponse.user?.collection ?? ""),
                  supervisor_id: int.parse(loginResponse.user?.supervisorId ?? "")
          ));
        }
        db.store.close();
        emit(ProfilesLoaded(1,double.parse(loginResponse?.user?.commission ?? "0"),double.parse(loginResponse?.user?.collection ?? "0")));

      } catch (error) {
        emit(ProfileError(error.toString()));
      }
    });
  }
}