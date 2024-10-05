import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/customer_info/customer_info_bloc.dart';
import 'package:ssc/application/customer/social_media/social_media_bloc.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/common/custom_snackbar.dart';
import 'package:ssc/presentation/utils/common/loading_shimmer.dart';
import 'package:ssc/presentation/utils/image_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

part './Widgets/banner_widget.dart';
part './Widgets/link_widget.dart';
part './Widgets/feedback_widget.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dashboard'),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadingShimmer.withChild(
                      enabled: state.isLoading, child: BannerWidget()),
                  LinkWidget(),
                  LoadingShimmer.withChild(
                    center: false,
                    enabled: state.isLoading,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 5.0, bottom: 2.0),
                      child: Text(
                        'Available Services',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  LoadingShimmer.withChild(
                    center: false,
                    enabled: state.isLoading,
                    child: InkWell(
                      onTap: () async {
                        Navigator.pushNamed(
                          context,
                          RoutePath.customerServicePage,
                        );
                      },
                      child: Card(
                        elevation: 3,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Electricity',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.electric_bolt,
                                size: 26,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  LoadingShimmer.withChild(
                    center: false,
                    enabled: state.isLoading,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 5.0, bottom: 2.0),
                      child: Text(
                        'Others',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  LoadingShimmer.withChild(
                    center: false,
                    enabled: state.isLoading,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        RoutePath.customerReviewPage,
                      ),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reviews',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.reviews,
                                size: 26,
                              )
                            ],
                          ),
                        ),
                      ),
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
