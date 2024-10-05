part of 'customer_login_bloc.dart';

@immutable
sealed class CustomerLoginEvent {}
class CustomerLoginFetchEvent extends CustomerLoginEvent {
  final String mobileNumber;
  final String password;
  CustomerLoginFetchEvent({required this.mobileNumber, required this.password});
}