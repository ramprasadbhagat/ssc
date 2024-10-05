part of 'customer_login_bloc.dart';
class CustomerLoginState {
  final bool isLoading;
  final bool isError;
  final Option<Either<String, CustomerInfo>> apiFailureOrSuccessOption;
  final CustomerInfo customerInfo;


  CustomerLoginState({
    required this.isLoading,
    required this.isError,
    required this.apiFailureOrSuccessOption,
    required this.customerInfo,
  });

  factory CustomerLoginState.initial() {
    return CustomerLoginState(
      isLoading: false,
      isError: false,
      apiFailureOrSuccessOption: none(),
      customerInfo: CustomerInfo.empty(),
    );
  }

  CustomerLoginState copyWith({
    bool? isRecording,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    Option<Either<String, CustomerInfo>>? apiFailureOrSuccessOption,
    CustomerInfo? customerInfo,
  }) {
    return CustomerLoginState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      apiFailureOrSuccessOption: apiFailureOrSuccessOption ?? this.apiFailureOrSuccessOption,
      customerInfo: customerInfo ?? this.customerInfo
    );
  }
}
