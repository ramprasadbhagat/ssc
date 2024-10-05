part of 'eligibility_bloc.dart';

@immutable
sealed class EligibilityEvent {}

class EligibilityInitialEvent extends EligibilityEvent {
  EligibilityInitialEvent();
}

class EligibilityUpdateEvent extends EligibilityEvent {
  final CustomerInfo customerInfo;
  EligibilityUpdateEvent({required this.customerInfo});
}