import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(UnAuthenticatedState()) {
    on<AuthInitiateEvent>(
      (event, emit) => add(AuthFetchEvent()),
    );
    on<AuthFetchEvent>((event, emit) async {
      final failureOrSuccessOption = await authRepository.getCredential();
      await failureOrSuccessOption.fold(
        (failure) async => emit(UnAuthenticatedState()),
        (customerInfo) async => customerInfo.isPhoneNumberPasswordEmpty
            ? emit(UnAuthenticatedState())
            : emit(AuthenticatedState(customerInfo: customerInfo)),
      );
    });

    on<AuthOutEvent>((event, emit) async {
      await authRepository.clearCredential();
      emit(UnAuthenticatedState());
    });
  }
}
