import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/auth/repository/auth_repository.dart';
import 'package:ssc/infrastructure/customer_sign_up/repository/customer_sign_up_repository.dart';

part 'customer_sign_up_event.dart';
part 'customer_sign_up_state.dart';

class CustomerSignUpBloc
    extends Bloc<CustomerSignUpEvent, CustomerSignUpState> {
  AuthRepository authRepository;
  CustomerSignUpRepository customerSignUpRepository;
  CustomerSignUpBloc(
      {required this.customerSignUpRepository, required this.authRepository})
      : super(CustomerSignUpState.initial()) {
    on<CustomerSignUpInitiateEvent>(
      (event, emit) => emit(state.copyWith(customerInfo: event.customerInfo)),
    );
    on<CustomerSignUpFetchEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));
      final failureOrSuccessOption = await customerSignUpRepository
          .registerUser(customerInfo: state.customerInfo);

      await failureOrSuccessOption.fold(
        (failure) async {
          emit(state.copyWith(
            apiFailureOrSuccessOption: optionOf(Left(failure)),
            isLoading: false,
          ));
        },
        (customerInfo) async {
          //store credential
          final auth = await authRepository.storeCredential(
              phoneNumber: customerInfo.phoneNumber,
              password: state.customerInfo.password,
              cookie: customerInfo.cookie);

          await auth.fold(
            (failure) async {
              emit(state.copyWith(
                apiFailureOrSuccessOption: optionOf(Right(customerInfo)),
                isLoading: false,
              ));
            },
            (_) async {
              emit(
                state.copyWith(
                  apiFailureOrSuccessOption: optionOf(Right(customerInfo)),
                  isLoading: false,
                  customerInfo: customerInfo.copyWith(password: state.customerInfo.password),
                ),
              );
            },
          );
        },
      );
    });
  }
}
