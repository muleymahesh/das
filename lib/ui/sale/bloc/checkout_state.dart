part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();
}

final class CheckoutInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class BookingSuccess extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class BookingFailure extends CheckoutState {
  final String error;

  const BookingFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class BookingLoading extends CheckoutState {
  @override
  List<Object> get props => [];
}
