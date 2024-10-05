import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ssc/domain/model/service_entity.dart';
import 'package:ssc/infrastructure/service_list/repository/service_list_repository.dart';

part 'service_list_event.dart';
part 'service_list_state.dart';

class ServiceListBloc extends Bloc<ServiceListEvent, ServiceListState> {

  final ServiceListRepository serviceListRepository;
  ServiceListBloc({required this.serviceListRepository}) : super(ServiceListState.initial()) {
    on<ServiceListFetchEvent>((event, emit) async {
            emit(state.copyWith(
        isLoading: true,
      ));
      final failureOrSuccessOption = await serviceListRepository.fetchServiceList();

      await failureOrSuccessOption.fold(
        (failure) async {
          emit(state.copyWith(
            apiFailureOrSuccessOption: optionOf(Left(failure)),
            isLoading: false,
          ));
        },
        (serviceEntityList) async {
          emit(
            state.copyWith(
              apiFailureOrSuccessOption: optionOf(Right(serviceEntityList)),
              isLoading: false,
              serviceEntityList: serviceEntityList,
            ),
          );
        },
      );
    
    });
  }
}
