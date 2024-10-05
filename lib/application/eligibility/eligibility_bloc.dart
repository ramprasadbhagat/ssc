import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';

part 'eligibility_event.dart';
part 'eligibility_state.dart';

class EligibilityBloc extends Bloc<EligibilityEvent, EligibilityState> {
  EligibilityBloc() : super(EligibilityState.initial()) {
    on<EligibilityInitialEvent>((event, emit) => emit(EligibilityState.initial()));
    
    on<EligibilityUpdateEvent>((event, emit)=> emit(state.copyWith(customerInfo: event.customerInfo)));
  }
}
