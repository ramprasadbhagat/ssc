part of 'customer_sign_up_bloc.dart';

@immutable
sealed class CustomerSignUpEvent {}

class CustomerSignUpFetchEvent extends CustomerSignUpEvent {}

class CustomerSignUpInitiateEvent extends CustomerSignUpEvent {
  final CustomerInfo customerInfo;
  CustomerSignUpInitiateEvent({required this.customerInfo});
}
