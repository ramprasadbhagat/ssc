import 'package:flutter/material.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class EngineerHomePage extends StatelessWidget {
  const EngineerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dashboard'),
        centerTitle: true,
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushNamed(context, RoutePath.loginOptionPage);
                // await SharedPreferencesHelper().clearLoginState();
              },    
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0.h, left: 5.0.w, bottom: 2.0.h),
              child: Text(
                'Available Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                RoutePath.engineerTaskPage,
              ),
              child: Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Electricity',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
            Padding(
              padding: EdgeInsets.only(top: 20.0.h, left: 5.0.w, bottom: 2.0.h),
              child: Text(
                'Others',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                RoutePath.engineerReviewPage,
              ),
              child: Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
          
          ],
        ),
      ),
    );
  }
}
