import 'package:flutter/material.dart';
import 'package:ssc/presentation/utils/image_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Payment'),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Scan QR Code',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Center(
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange.shade200, // Set the border color
                          width: 3, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // Optional: Set the border radius
                      ),
                      height: 270.0.h,
                      child: Image.asset(
                        ImagePath.payment,
                      ),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Text('Scan to proceed your payment'),
                    SizedBox(
                      height: 10.0.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
