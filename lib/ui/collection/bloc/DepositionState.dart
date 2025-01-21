// Events
import 'package:das_app/data/model/deposition_response.dart';

import '../../../data/model/Deposition.dart';

abstract class DepositionEvent {}

class LoadDepositions extends DepositionEvent {}
class SubmitDepositions extends DepositionEvent {
  final Deposition deposition;
  SubmitDepositions(this.deposition);
}

// States
abstract class DepositionState {}

class DepositionsLoading extends DepositionState {}

class DepositionsLoaded extends DepositionState {
  final List<Requests> depositions;
  final double collection;

  DepositionsLoaded(this.depositions,  this.collection);
}

class DepositionError extends DepositionState {
  final String error;

  DepositionError(this.error);
}