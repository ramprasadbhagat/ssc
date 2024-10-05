import 'package:flutter/material.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/image_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class LoginOptionPage extends StatelessWidget {
  const LoginOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(ImagePath.background), // Your background image
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), // Adjust the opacity as needed
                  BlendMode.color,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sunrise Service Centre',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, RoutePath.loginAsCustomerPage),
                    child: const Text('Login as Customer')),
                const Text(
                  'or',
                  style: TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, RoutePath.loginAsEngineerPage),
                    child: const Text('Login as Engineer')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
