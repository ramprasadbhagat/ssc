import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssc/application/customer/auth/auth_bloc.dart';
import 'package:ssc/application/customer/customer_info/customer_info_bloc.dart';
import 'package:ssc/application/customer/customer_login/customer_login_bloc.dart';
import 'package:ssc/application/customer/customer_sign_up/customer_sign_up_bloc.dart';
import 'package:ssc/application/customer/service_list/service_list_bloc.dart';
import 'package:ssc/application/eligibility/eligibility_bloc.dart';
import 'package:ssc/application/customer/service_detail_request/service_detail_request_bloc.dart';
import 'package:ssc/application/customer/social_media/social_media_bloc.dart';
import 'package:ssc/locator.dart';
import 'package:ssc/presentation/helper/share_preference_helper.dart';
import 'package:ssc/presentation/routes/routes.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/device_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferencesHelper().init();
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // String getRoute() {
  //   bool isCustomerLoggedIn = SharedPreferencesHelper().getCustomerLoginState();
  //   bool isEngineerLoggedIn = SharedPreferencesHelper().getEngineerLoginState();

  //   String route;
  //   if (isCustomerLoggedIn) {
  //     route = RoutePath.customerHomeNav;
  //   } else if (isEngineerLoggedIn) {
  //     route = RoutePath.engineerHomePage;
  //   } else {
  //     route = RoutePath.loginOptionPage;
  //   }
  //   return route;
  // }

  @override
  Widget build(BuildContext context) {
    DeviceSize.init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<AuthBloc>()..add(AuthInitiateEvent()),
        ),
        BlocProvider(
          create: (context) => locator<EligibilityBloc>(),
        ),
        BlocProvider(
          create: (context) => ServiceDetailRequestBloc(),
        ),
        BlocProvider(
          create: (context) => locator<CustomerInfoBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<CustomerLoginBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<CustomerSignUpBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<SocialMediaBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<ServiceListBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Sunrise Service Centre',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          canvasColor: Colors.orange.shade300,
          primaryColor: Colors.white,
        ),
        initialRoute: RoutePath.splashPage,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
