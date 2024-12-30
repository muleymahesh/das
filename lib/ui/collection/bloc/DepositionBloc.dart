import 'package:das_app/data/db/objectbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';

import '../../../data/model/Deposition.dart';
import 'DepositionState.dart';


class DepositionBloc extends Bloc<DepositionEvent, DepositionState> {

  DepositionBloc() : super(DepositionsLoading()) {
    on<LoadDepositions>((event, emit) async {
      emit(DepositionsLoading());
      try {
        ObjectBox db  = await ObjectBox.create();
        final box = db.store.box<Deposition>();
        final depositions = box.getAll();
        db.store.close();
        emit(DepositionsLoaded(depositions));
      } catch (e) {
        emit(DepositionError(e.toString()));
      }
    });
    on<SubmitDepositions>((event, emit) async {
      emit(DepositionsLoading());
      try {
        ObjectBox db  = await ObjectBox.create();
        final box = db.store.box<Deposition>();
        box.put(event.deposition);

        final depositions = box.getAll();
        db.store.close();
        emit(DepositionsLoaded(depositions));
      } catch (e) {
        emit(DepositionError(e.toString()));
      }
    });
    }
}