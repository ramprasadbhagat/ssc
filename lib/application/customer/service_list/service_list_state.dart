part of 'service_list_bloc.dart';


class ServiceListState {
  final bool isLoading;
  final List<ServiceEntity> serviceEntityList;
  final Option<Either<String, List<ServiceEntity>>> apiFailureOrSuccessOption;



  ServiceListState({
    required this.isLoading,
    required this.serviceEntityList,
    required this.apiFailureOrSuccessOption,
  });

  factory ServiceListState.initial() {
    return ServiceListState(
      isLoading: false,
      serviceEntityList: <ServiceEntity>[],
      apiFailureOrSuccessOption: none(),
    );
  }

  ServiceListState copyWith({
    bool? isLoading,
    List<dynamic>? recordings,
    List<ServiceEntity>? serviceEntityList,
    bool? isError,
    bool? isSuccess,
    Option<Either<String, List<ServiceEntity>>>? apiFailureOrSuccessOption,
  }) {
    return ServiceListState(
      isLoading: isLoading ?? this.isLoading,
      apiFailureOrSuccessOption: apiFailureOrSuccessOption ?? this.apiFailureOrSuccessOption,
      serviceEntityList: serviceEntityList ?? this.serviceEntityList
    );
  }
}

