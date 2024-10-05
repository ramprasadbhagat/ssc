import 'package:flutter/material.dart';
import 'package:ssc/domain/model/service_entity.dart';
import 'package:ssc/domain/model/ticket_entity.dart';
import 'package:ssc/presentation/customer/login/customer_phone_verification_page.dart';
import 'package:ssc/presentation/customer/review/customer_review_page.dart';
import 'package:ssc/presentation/engineer/home/engineer_home_page.dart';
import 'package:ssc/presentation/engineer/login/engineer_reset_password_page.dart';
import 'package:ssc/presentation/engineer/review/engineer_review_page.dart';
import 'package:ssc/presentation/engineer/task/engineer_task_page.dart';
import 'package:ssc/presentation/engineer/ticket/ticket_page.dart';
import 'package:ssc/presentation/common/error_page.dart';
import 'package:ssc/presentation/engineer/ticket_detail/ticket_details_page.dart';
import 'package:ssc/presentation/home_nav.dart';
import 'package:ssc/presentation/customer/login/customer_reset_password_page.dart';
import 'package:ssc/presentation/customer/login/login_as_customer_page.dart';
import 'package:ssc/presentation/engineer/login/login_as_engineer_page.dart';
import 'package:ssc/presentation/customer/login/sign_up_as_customer_page.dart';
import 'package:ssc/presentation/login/login_option_page.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/customer/service/service_page.dart';
import 'package:ssc/presentation/customer/service_detail/service_detail_page.dart';
import 'package:ssc/presentation/splash_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //customer login
      case RoutePath.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      //customer login
      case RoutePath.loginOptionPage:
        return MaterialPageRoute(builder: (_) => const LoginOptionPage());
      case RoutePath.signUpAsCustomerPage:
        return MaterialPageRoute(builder: (_) => const SignUpAsCustomer());
      case RoutePath.loginAsCustomerPage:
        return MaterialPageRoute(builder: (_) => const LoginAsCustomer());
      case RoutePath.customerResetPasswordPage:
        return MaterialPageRoute(builder: (_) => CustomerResetPasswordPage());

      //engineer login
      case RoutePath.loginAsEngineerPage:
        return MaterialPageRoute(builder: (_) => const LoginAsEngineer());
      case RoutePath.engineerResetPasswordPage:
        return MaterialPageRoute(builder: (_) => EngineerResetPasswordPage());

      //customer
      case RoutePath.customerHomeNav:
        return MaterialPageRoute(builder: (_) => const HomeNav());
      case RoutePath.customerServicePage:
        return MaterialPageRoute(builder: (_) => const ServicePage());

      case RoutePath.customerServiceDetailPage:
        if (settings.arguments is ServiceEntity) {
          final ServiceEntity serviceEntity =
              settings.arguments as ServiceEntity;
          return MaterialPageRoute(
              builder: (context) =>
                  ServiceDetailPage(serviceEntity: serviceEntity));
        }
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
      case RoutePath.customerPhoneVerificationPage:

        // return MaterialPageRoute(builder: (_) => CustomerPhoneVerificationPage());
        if (settings.arguments is String) {
          final verificationId = settings.arguments as String;
          return MaterialPageRoute(
              builder: (_) => CustomerPhoneVerificationPage(
                    verificationId: verificationId,
                  ));
        }
        return MaterialPageRoute(builder: (context) => const ErrorScreen());

      //engineer
      case RoutePath.engineerHomePage:
        return MaterialPageRoute(builder: (_) => EngineerHomePage());
      case RoutePath.engineerTaskPage:
        return MaterialPageRoute(builder: (_) => EngineerTaskPage());
      case RoutePath.engineerTicketPage:
        return MaterialPageRoute(builder: (_) => TicketPage());
      case RoutePath.engineerTicketDetailsPage:
        if (settings.arguments is TicketEntity) {
          final TicketEntity ticketEntity = settings.arguments as TicketEntity;
          return MaterialPageRoute(
              builder: (context) =>
                  TicketDetailsPage(ticketEntity: ticketEntity));
        }
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
      case RoutePath.engineerReviewPage:
        return MaterialPageRoute(builder: (_) => EngineerReviewPage());
      case RoutePath.customerReviewPage:
        return MaterialPageRoute(builder: (context) => CustomerReviewPage());

      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}
