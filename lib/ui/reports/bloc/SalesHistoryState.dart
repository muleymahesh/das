// lib/ui/reports/bloc/SalesHistoryState.dart
import 'package:equatable/equatable.dart';

import '../../../data/model/SalesHistory.dart';

abstract class SalesHistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class SalesHistoryLoading extends SalesHistoryState {}

class SalesHistoryLoaded extends SalesHistoryState {
  final List<SalesHistory> salesHistory;

  SalesHistoryLoaded(this.salesHistory);

  @override
  List<Object> get props => [salesHistory];
}

class SalesHistoryError extends SalesHistoryState {
  final String error;

  SalesHistoryError(this.error);

  @override
  List<Object> get props => [error];
}