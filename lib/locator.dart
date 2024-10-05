import 'package:get_it/get_it.dart';
import 'package:ssc/application/customer/auth/auth_bloc.dart';
import 'package:ssc/application/customer/customer_info/customer_info_bloc.dart';
import 'package:ssc/application/customer/customer_login/customer_login_bloc.dart';
import 'package:ssc/application/customer/customer_sign_up/customer_sign_up_bloc.dart';
import 'package:ssc/application/customer/service_list/service_list_bloc.dart';
import 'package:ssc/application/eligibility/eligibility_bloc.dart';
import 'package:ssc/application/customer/social_media/social_media_bloc.dart';
import 'package:ssc/config.dart';
import 'package:ssc/infrastructure/auth/data_source/auth_remote_data_source.dart';
import 'package:ssc/infrastructure/auth/repository/auth_repository.dart';
import 'package:ssc/infrastructure/core/dio_service.dart';
import 'package:ssc/infrastructure/customer_info/data_source/customer_info_remote_data_source.dart';
import 'package:ssc/infrastructure/customer_info/repository/customer_info_repository.dart';
import 'package:ssc/infrastructure/customer_login/data_source/remote_data_source.dart';
import 'package:ssc/infrastructure/customer_login/repository/customer_login_repository.dart';
import 'package:ssc/infrastructure/customer_sign_up/data_source/remote_data_source.dart';
import 'package:ssc/infrastructure/customer_sign_up/repository/customer_sign_up_repository.dart';
import 'package:ssc/infrastructure/service_list/data_source/service_list_remote_data_source.dart';
import 'package:ssc/infrastructure/service_list/repository/service_list_repository.dart';
import 'package:ssc/infrastructure/social_media/data_source/remote_data_source.dart';
import 'package:ssc/infrastructure/social_media/repository/customer_sign_up_repository.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => Config());
  locator.registerLazySingleton(() => DioService(config: locator<Config>()));

  //************************** Auth **************************

  locator.registerLazySingleton(() => AuthRemoteDataSource());

  locator.registerLazySingleton(() =>
      AuthRepository(authRemoteDataSource: locator<AuthRemoteDataSource>()));

  locator.registerLazySingleton(
      () => AuthBloc(authRepository: locator<AuthRepository>()));
  //************************** customer sign up **************************

  //************************** customer sign up **************************
  locator.registerLazySingleton(
      () => CustomerSignUpRemoteDataSource(dioService: locator<DioService>()));

  locator.registerLazySingleton(() => CustomerSignUpRepository(
      customerSignUpRemoteDataSource:
          locator<CustomerSignUpRemoteDataSource>()));

  locator.registerLazySingleton(() => CustomerSignUpBloc(
      customerSignUpRepository: locator<CustomerSignUpRepository>(),
      authRepository: locator<AuthRepository>()));
  //************************** customer sign up **************************

  //************************** customer Login **************************
  locator.registerLazySingleton(
      () => CustomerLoginRemoteDataSource(dioService: locator<DioService>()));

  locator.registerLazySingleton(() => CustomerLoginRepository(
      customerLoginRemoteDataSource: locator<CustomerLoginRemoteDataSource>()));

  locator.registerLazySingleton(() => CustomerLoginBloc(
      customerLoginRepository: locator<CustomerLoginRepository>(),
      authRepository: locator<AuthRepository>()));
  //************************** customer Login **************************

  //************************** customer info **************************
  locator.registerLazySingleton(
      () => CustomerInfoRemoteDataSource(dioService: locator<DioService>()));

  locator.registerLazySingleton(() => CustomerInfoRepository(
      customerInfoRemoteDataSource: locator<CustomerInfoRemoteDataSource>()));

  locator.registerLazySingleton(() => CustomerInfoBloc(
      customerInfoRepository: locator<CustomerInfoRepository>()));
  //************************** customer sign up **************************

  //************************** Service List **************************

  locator.registerLazySingleton(
      () => ServiceListRemoteDataSource(dioService: locator<DioService>()));

  locator.registerLazySingleton(() => ServiceListRepository(
      serviceListRemoteDataSource: locator<ServiceListRemoteDataSource>()));

  locator.registerLazySingleton(()=> ServiceListBloc(serviceListRepository: locator<ServiceListRepository>()));
  

  // locator.registerLazySingleton(()=> CustomerLoginBloc(customerLoginRepository: locator<CustomerLoginRepository>()));
  //************************** Service List **************************

  //************************** Eligibility Bloc **************************
  locator.registerLazySingleton(() => EligibilityBloc());

  //************************** Eligibility Bloc **************************

  //************************** customer sign up **************************
  locator.registerLazySingleton(
      () => SocialMediaRemoteDataSource(dioService: locator<DioService>()));

  locator.registerLazySingleton(() => SocialMediaRepository(
      socialMediaRemoteDataSource: locator<SocialMediaRemoteDataSource>()));

  locator.registerLazySingleton(() =>
      SocialMediaBloc(socialMediaRepository: locator<SocialMediaRepository>()));
  //************************** customer sign up **************************
}
