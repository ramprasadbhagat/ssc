part of 'auth_bloc.dart';

class AuthState{}
class AuthenticatedState extends AuthState {
  final CustomerInfo customerInfo;
  AuthenticatedState({required this.customerInfo});
}

class UnAuthenticatedState extends AuthState {}
