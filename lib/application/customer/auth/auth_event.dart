part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthInitiateEvent extends AuthEvent {}

class AuthFetchEvent extends AuthEvent {}

class AuthOutEvent extends AuthEvent {}
