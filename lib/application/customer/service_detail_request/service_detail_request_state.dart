part of 'service_detail_request_bloc.dart';

class ServiceDetailRequestBlocState {
  final bool isLoading;
  final CustomerInfo customerInfo;
  final ServiceEntity serviceEntity;

  final bool isError;

  ServiceDetailRequestBlocState({
    required this.customerInfo,
    required this.isLoading,
    required this.serviceEntity,
    required this.isError,
  });

  factory ServiceDetailRequestBlocState.initial() {
    return ServiceDetailRequestBlocState(
      customerInfo: CustomerInfo.empty(),
      isLoading: false,
      serviceEntity: ServiceEntity.empty(),
      isError: false,

    );
  }

  ServiceDetailRequestBlocState copyWith({
    CustomerInfo? customerInfo,
    bool? isLoading,
    ServiceEntity? serviceEntity,
    bool? isError,
  }) {
    return ServiceDetailRequestBlocState(
      isLoading: isLoading ?? this.isLoading,
      serviceEntity: serviceEntity ?? this.serviceEntity,
      isError: isError ?? this.isError,
      customerInfo: customerInfo ?? this.customerInfo,
    );
  }

  bool get isVideoFileEmpty => serviceEntity.videoFile.path.isEmpty;
}