part of 'customer_sign_up_bloc.dart';


class CustomerSignUpState {
  final bool isRecording;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final CustomerInfo customerInfo;
  final Option<Either<String, CustomerInfo>> apiFailureOrSuccessOption;

  final List<dynamic> recordings;

  CustomerSignUpState({
    required this.isRecording,
    required this.isLoading,
    required this.recordings,
    required this.isError,
    required this.isSuccess,
    required this.customerInfo,
    required this.apiFailureOrSuccessOption,
  });

  factory CustomerSignUpState.initial() {
    return CustomerSignUpState(
      isRecording: false,
      isLoading: false,
      recordings: [],
      isError: false,
      isSuccess: false,
      customerInfo: CustomerInfo.empty(),
      apiFailureOrSuccessOption: none(),
    );
  }

  CustomerSignUpState copyWith({
    bool? isRecording,
    bool? isLoading,
    List<dynamic>? recordings,
    CustomerInfo? customerInfo,
    bool? isError,
    bool? isSuccess,
    Option<Either<String, CustomerInfo>>? apiFailureOrSuccessOption,
  }) {
    return CustomerSignUpState(
      isRecording: isRecording ?? this.isRecording,
      isLoading: isLoading ?? this.isLoading,
      recordings: recordings ?? this.recordings,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      customerInfo: customerInfo ?? this.customerInfo,
      apiFailureOrSuccessOption: apiFailureOrSuccessOption ?? this.apiFailureOrSuccessOption,
    );
  }
}
