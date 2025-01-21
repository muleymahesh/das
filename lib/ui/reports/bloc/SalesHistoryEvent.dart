// lib/ui/reports/bloc/SalesHistoryEvent.dart
import 'package:equatable/equatable.dart';

abstract class SalesHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSalesHistory extends SalesHistoryEvent {}