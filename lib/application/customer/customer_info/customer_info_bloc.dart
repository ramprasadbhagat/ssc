import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/customer_info/repository/customer_info_repository.dart';

part 'customer_info_event.dart';
part 'customer_info_state.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  CustomerInfoRepository customerInfoRepository;
  CustomerInfoBloc({required this.customerInfoRepository})
      : super(CustomerInfoState.initial()) {
    on<CustomerInfoInitiateEvent>(
      (event, emit) => emit(CustomerInfoState.initial()),
    );
    on<CustomerInfoFetchEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));
      final failureOrSuccessOption = await customerInfoRepository
          .getCustomerInfo(customerInfo: event.customerInfo);

      await failureOrSuccessOption.fold(
        (failure) async {
          emit(state.copyWith(
            apiFailureOrSuccessOption: optionOf(Left(failure)),
            isLoading: false,
          ));
        },
        (customerInfo) async {
          emit(
            state.copyWith(
              apiFailureOrSuccessOption: optionOf(Right(customerInfo)),
              isLoading: false,
              customerInfo: customerInfo.copyWith(password: state.customerInfo.password),
            ),
          );
        },
      );
    
    });
  
  }
}
