import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/auth/auth_bloc.dart';
import 'package:ssc/application/customer/customer_info/customer_info_bloc.dart';
import 'package:ssc/application/eligibility/eligibility_bloc.dart';
import 'package:ssc/presentation/utils/common/loading_shimmer.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Profile'),
        centerTitle: true,
        leading: const SizedBox.shrink(), // Empty space instead of back button
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.0.h,
                  ),
                  // Profile Image
                  Icon(
                    Icons.person,
                    size: 80.0.h,
                  ),
                  SizedBox(height: 36.0.h),
                  
                  // Name
                  Row(
                    children: [
                      Icon(Icons.person_2, color: Colors.blue),
                      SizedBox(width: 10),
                      LoadingShimmer.withChild(
                        enabled: state.isLoading,
                        child: Text(
                          state.customerInfo.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),

                  // Email
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue),
                      SizedBox(width: 10),
                      LoadingShimmer.withChild(
                        enabled: state.isLoading,
                        child: Text(
                          state.customerInfo.email,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),

                  // Phone Number
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),
                      SizedBox(width: 10),
                      LoadingShimmer.withChild(
                        enabled: state.isLoading,
                        child: Text(
                          '+91 ${state.customerInfo.phoneNumber}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),

                  // Address
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.blue),
                      SizedBox(width: 10),
                      LoadingShimmer.withChild(
                        enabled: state.isLoading,
                        child: Text(
                          state.customerInfo.address,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),

                  // Logout
                  InkWell(
                    onTap: () async {
                      context.read<AuthBloc>().add(AuthOutEvent());
                      context
                          .read<EligibilityBloc>()
                          .add(EligibilityInitialEvent());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.blue),
                        SizedBox(width: 10),
                        const Text(
                          'Logout',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
