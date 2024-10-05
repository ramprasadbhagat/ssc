import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/auth/auth_bloc.dart';
import 'package:ssc/application/customer/customer_info/customer_info_bloc.dart';
import 'package:ssc/application/customer/customer_login/customer_login_bloc.dart';
import 'package:ssc/application/customer/customer_sign_up/customer_sign_up_bloc.dart';
import 'package:ssc/application/customer/service_list/service_list_bloc.dart';
import 'package:ssc/application/eligibility/eligibility_bloc.dart';
import 'package:ssc/application/customer/social_media/social_media_bloc.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/common/custom_snackbar.dart';
import 'package:ssc/presentation/utils/image_path.dart';

class SplashPage extends StatelessWidget {
  const SplashPage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthenticatedState) {
              //only require phoneNumber and password
              context.read<CustomerInfoBloc>().add(
                  CustomerInfoFetchEvent(customerInfo: state.customerInfo));
              context.read<SocialMediaBloc>().add(SocialMediaFetchEvent());
              context.read<ServiceListBloc>().add(ServiceListFetchEvent());

              
              Navigator.pushNamed(context, RoutePath.customerHomeNav);
            } else if (state is UnAuthenticatedState) {
              Navigator.pushNamed(context, RoutePath.loginOptionPage);
            }
          },
        ),
        BlocListener<CustomerSignUpBloc, CustomerSignUpState>(
          listenWhen: (previous, current) =>
              previous.apiFailureOrSuccessOption !=
              current.apiFailureOrSuccessOption,
          listener: (context, state) {
            state.apiFailureOrSuccessOption.fold(() {}, (either) async {
              either.fold((leftMessage) {
                CustomSnackbar.showErrorMessage(
                  context,
                  leftMessage,
                );
              }, (_) {
                CustomSnackbar.showSuccessMessage(context, 'Account created successfully');
                Navigator.pushNamed(context, RoutePath.loginAsCustomerPage);
              });
            });
          },
        ),
        BlocListener<CustomerLoginBloc, CustomerLoginState>(
          listenWhen: (previous, current) =>
              previous.apiFailureOrSuccessOption !=
              current.apiFailureOrSuccessOption,
          listener: (context, state) {
            state.apiFailureOrSuccessOption.fold(() {}, (either) async {
              either.fold((leftMessage) {
                CustomSnackbar.showErrorMessage(
                  context,
                  leftMessage,
                );
              }, (r) {
                context.read<AuthBloc>().add(AuthFetchEvent());
                CustomSnackbar.showSuccessMessage(context, 'Login successfully');
              });
            });
          },
        ),
        BlocListener<CustomerInfoBloc, CustomerInfoState>(
          listenWhen: (previous, current) =>
              previous.apiFailureOrSuccessOption != current.apiFailureOrSuccessOption,
          listener: (context, state) {
            state.apiFailureOrSuccessOption.fold(() {}, (either) async {
              either.fold((leftMessage) {
                CustomSnackbar.showErrorMessage(
                  context,
                  leftMessage,
                );
              }, (customerInfo) {
              context
                  .read<EligibilityBloc>()
                  .add(EligibilityUpdateEvent(customerInfo: customerInfo));
              },
            );
            
          },
            ); },
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Image.asset(
          ImagePath.appLogo,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
