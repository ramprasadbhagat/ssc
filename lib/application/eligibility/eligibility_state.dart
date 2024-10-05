part of 'eligibility_bloc.dart';
class EligibilityState {
  final CustomerInfo customerInfo;


  EligibilityState({
    required this.customerInfo,
  });

  factory EligibilityState.initial() {
    return EligibilityState(
      customerInfo: CustomerInfo.empty(),
    );
  }

  EligibilityState copyWith({

    CustomerInfo? customerInfo,
  }) {
    return EligibilityState(
      customerInfo: customerInfo ?? this.customerInfo
    );
  }
}
