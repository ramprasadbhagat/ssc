import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:ssc/application/customer/customer_info/customer_info_bloc.dart';
import 'package:ssc/application/customer/customer_sign_up/customer_sign_up_bloc.dart';
import 'package:ssc/presentation/utils/common/custom_snackbar.dart';
import 'package:ssc/presentation/utils/common/loading_shimmer.dart';
import 'package:ssc/presentation/utils/image_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class CustomerPhoneVerificationPage extends StatefulWidget {
  final String verificationId;
  CustomerPhoneVerificationPage({
    required this.verificationId,
  });
  @override
  _CustomerPhoneVerificationPageState createState() =>
      _CustomerPhoneVerificationPageState();
}

class _CustomerPhoneVerificationPageState
    extends State<CustomerPhoneVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    final otp = _otpController.text;
    if (otp.isEmpty) {
      CustomSnackbar.showErrorMessage(context, 'Please enter your otp');
      return;
    }
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      CustomSnackbar.showErrorMessage(
        context,
        'Wrong otp',
      );
      return;
    }
    print('Entered OTP: $otp');
    context.read<CustomerSignUpBloc>().add(CustomerSignUpFetchEvent());
  }

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
                  Colors.black
                      .withOpacity(0.6), // Adjust the opacity as needed
                  BlendMode.color,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back))),
                SizedBox(
                  height: 86.0.h,
                ),
                Image.asset(
                  ImagePath.loginLogo,
                  height: 100.0.h,
                ),
                Center(
                  child: Text(
                    'Phone Verification',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                Text(
                  'Enter the OTP sent to your phone',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.0.h),
                Pinput(
                  controller: _otpController,
                  focusNode: _focusNode,
                  length: 6, // Length of the OTP
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  onCompleted: (pin) async {},
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
                  buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    return LoadingShimmer.withChild(
                      enabled: state.isLoading,
                      child: ElevatedButton(
                        onPressed: () async => await _verifyOTP(),
                        child: Text('Verify OTP'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
