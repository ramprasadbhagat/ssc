part of 'service_detail_request_bloc.dart';

abstract class ServiceDetailRequestEvent {}

class ServiceDetailRequestInitialEvent extends ServiceDetailRequestEvent {
  final CustomerInfo customerInfo;
  final ServiceEntity serviceEntity;
  ServiceDetailRequestInitialEvent({required this.customerInfo, required this.serviceEntity});
}

class ServiceDetailRequestSubmitRequestEvent extends ServiceDetailRequestEvent {
  ServiceDetailRequestSubmitRequestEvent();
}

class ServiceDetailRequestSetVideoEvent extends ServiceDetailRequestEvent {
  final File videoFile;
  ServiceDetailRequestSetVideoEvent({required this.videoFile});
}

class ServiceDetailRequestSetNoteEvent extends ServiceDetailRequestEvent {
  final String requestNote;
  ServiceDetailRequestSetNoteEvent({required this.requestNote});
}

class ServiceDetailRequestDeleteEvent extends ServiceDetailRequestEvent {
  ServiceDetailRequestDeleteEvent();
}
