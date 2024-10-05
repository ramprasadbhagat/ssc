import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/domain/model/service_entity.dart';

part 'service_detail_request_event.dart';
part 'service_detail_request_state.dart';

class ServiceDetailRequestBloc extends Bloc<ServiceDetailRequestEvent, ServiceDetailRequestBlocState> {
  ServiceDetailRequestBloc() : super(ServiceDetailRequestBlocState.initial()) {

    on<ServiceDetailRequestInitialEvent>((event, emit) => emit(state.copyWith(
      customerInfo: event.customerInfo,
      serviceEntity: event.serviceEntity,
    )));

    on<ServiceDetailRequestSetVideoEvent>((event, emit) {
      emit(state.copyWith(serviceEntity: state.serviceEntity.copyWith(videoFile :event.videoFile)));
    });

    on<ServiceDetailRequestSetNoteEvent>((event, emit) {
      emit(state.copyWith(serviceEntity: state.serviceEntity.copyWith(requestedNote :event.requestNote)));
    });

    on<ServiceDetailRequestDeleteEvent>((event, emit) {
      emit(state.copyWith(serviceEntity: state.serviceEntity.copyWith(videoFile :File(''))));
    });

    on<ServiceDetailRequestSubmitRequestEvent>((event, emit) {
      // if(state.requestEntity.isEmpty) {
      //   emit(state.copyWith(isError: true));
      //   return;
      // }
      
    });


  }
}
