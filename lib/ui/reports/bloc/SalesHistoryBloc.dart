import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:das_app/data/remote/CustomerService.dart';
import 'SalesHistoryEvent.dart';
import 'SalesHistoryState.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  SalesHistoryBloc() : super(SalesHistoryLoading()) {
    on<LoadSalesHistory>((event, emit) async {
      emit(SalesHistoryLoading());
      try {
        final salesHistory = await CustomerService.getSalesHistory();
        emit(SalesHistoryLoaded(salesHistory));
      } catch (e) {
        emit(SalesHistoryError(e.toString()));
      }
    });
  }
}