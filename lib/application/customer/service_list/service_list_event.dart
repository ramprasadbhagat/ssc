part of 'service_list_bloc.dart';

@immutable
sealed class ServiceListEvent {}

class ServiceListFetchEvent extends ServiceListEvent {}
