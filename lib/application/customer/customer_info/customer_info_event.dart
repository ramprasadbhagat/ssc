part of 'customer_info_bloc.dart';

@immutable
sealed class CustomerInfoEvent {}

class CustomerInfoInitiateEvent extends CustomerInfoEvent {}

class CustomerInfoFetchEvent extends CustomerInfoEvent {
  final CustomerInfo customerInfo;
  CustomerInfoFetchEvent({required this.customerInfo});
}
