abstract class ProfileEvent {}

class LoadProfiles extends ProfileEvent {}

// States
abstract class ProfileState {}

class ProfilesLoading extends ProfileState {}

class ProfilesLoaded extends ProfileState {
  final int bookingCount;
  final double commission;
  final double collection;

  ProfilesLoaded(this.bookingCount,this.commission, this.collection);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
// Add new event for calculating commission
class GetUserData extends ProfileEvent {
}

// Add new state for commission
class CommissionCalculated extends ProfileState {
  final double commission;

  CommissionCalculated(this.commission);
}