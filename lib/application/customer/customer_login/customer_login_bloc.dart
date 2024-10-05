import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/auth/repository/auth_repository.dart';
import 'package:ssc/infrastructure/customer_login/repository/customer_login_repository.dart';

part 'customer_login_event.dart';
part 'customer_login_state.dart';

class CustomerLoginBloc extends Bloc<CustomerLoginEvent, CustomerLoginState> {
  final AuthRepository authRepository;
  final CustomerLoginRepository customerLoginRepository;
  CustomerLoginBloc(
      {required this.customerLoginRepository, required this.authRepository})
      : super(CustomerLoginState.initial()) {
    on<CustomerLoginFetchEvent>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          isError: false,
        ),
      );
      final failureOrSuccessOption = await customerLoginRepository.loginUser(
          mobileNumber: event.mobileNumber, password: event.password);

      await failureOrSuccessOption.fold(
        (failure) {
          emit(state.copyWith(
            apiFailureOrSuccessOption: optionOf(Left(failure)),
            isLoading: false,
            isError: true,
          ));
        },
        (customerInfo) async {
          //store credential
          final auth = await authRepository.storeCredential(
              phoneNumber: customerInfo.phoneNumber,
              password: event.password, 
              cookie: customerInfo.cookie,
              );

          await auth.fold(
            (failure) async {
              emit(state.copyWith(
                apiFailureOrSuccessOption: optionOf(Left(failure)),
                isLoading: false,
              ));
            },
            (_) async {
              emit(
                state.copyWith(
                  apiFailureOrSuccessOption: optionOf(Right(customerInfo)),
                  isLoading: false,
                  isError: false,
                  customerInfo: customerInfo.copyWith(password: event.password),
                ),
              );
            },
          );
        },
      );
    });
  }
}
