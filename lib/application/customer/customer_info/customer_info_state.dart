part of 'customer_info_bloc.dart';


class CustomerInfoState {
  final bool isLoading;
  final CustomerInfo customerInfo;
  final Option<Either<String, CustomerInfo>> apiFailureOrSuccessOption;

  final List<dynamic> recordings;

  CustomerInfoState({
    required this.isLoading,
    required this.recordings,
    required this.customerInfo,
    required this.apiFailureOrSuccessOption,
  });

  factory CustomerInfoState.initial() {
    return CustomerInfoState(
      isLoading: false,
      recordings: [],
      customerInfo: CustomerInfo.empty(),
      apiFailureOrSuccessOption: none(),
    );
  }

  CustomerInfoState copyWith({
    bool? isRecording,
    bool? isLoading,
    List<dynamic>? recordings,
    CustomerInfo? customerInfo,
    bool? isError,
    bool? isSuccess,
    Option<Either<String, CustomerInfo>>? apiFailureOrSuccessOption,
  }) {
    return CustomerInfoState(
      isLoading: isLoading ?? this.isLoading,
      recordings: recordings ?? this.recordings,
      customerInfo: customerInfo ?? this.customerInfo,
      apiFailureOrSuccessOption: apiFailureOrSuccessOption ?? this.apiFailureOrSuccessOption,
    );
  }
}
