import 'package:bloc/bloc.dart';
import 'package:das_app/data/model/UserModel.dart';
import 'package:das_app/data/model/user.dart';
import 'package:das_app/data/remote/LoginService.dart';
import 'package:das_app/ui/user/user_event.dart';
import 'package:equatable/equatable.dart';

import '../../data/db/objectbox.dart';


part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoading());
      try {
        // Replace with your login logic
        final loginResponse = await LoginService.login(event.username,
              event.password);
        if(loginResponse.error != null) {
          emit(UserLoginFailed(loginResponse.error ?? ''));
          return;
        }
        ObjectBox db  = await ObjectBox.create();
        final box = db.store.box<User>();
        box.removeAll();
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



        // final box1 = db.store.box<Product>();
        // if(box1.isEmpty())
        //   for (var value in stubProducts()) {
        //     box1.put(value);
        //   }

        db.store.close();
        emit(UserLoggedIn(loginResponse?.user ?? UserModel()));
      } catch (error) {
        emit(UserLoginFailed(error.toString()));
      }
    });
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
