import 'package:das_app/data/db/objectbox.dart';
import 'package:das_app/data/model/deposition_response.dart';
import 'package:das_app/data/model/user.dart';
import 'package:das_app/utils/StorageUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';

import '../../../data/model/Deposition.dart';
import '../../../data/remote/CustomerService.dart';
import 'DepositionState.dart';


class DepositionBloc extends Bloc<DepositionEvent, DepositionState> {

  DepositionBloc() : super(DepositionsLoading()) {
    on<LoadDepositions>((event, emit) async {
        emit(DepositionsLoading());
        final user = await StorageUtils.getUser();
        emit(DepositionsLoaded(await _fetchDepositions(user),user.collection));

    });
    on<SubmitDepositions>((event, emit) async {
      emit(DepositionsLoading());
      try {
        final user = await StorageUtils.getUser();
        await CustomerService.depositCollection(user.username, user.supervisor_id, event.deposition.amount);
        emit(DepositionsLoaded(await _fetchDepositions(user),user.collection));
      } catch (e) {
        emit(DepositionError(e.toString()));
      }
    });
    }

  Future<List<Requests>> _fetchDepositions(User user) async {
    final response = await CustomerService.fetchDepositionRequests(user.username, user.supervisor_id, user.collection);
    return response.requestsList ?? [];
  }
}