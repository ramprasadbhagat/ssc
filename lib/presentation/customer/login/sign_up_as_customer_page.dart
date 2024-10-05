import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/customer_sign_up/customer_sign_up_bloc.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/presentation/common/custom_text_field.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/common/custom_snackbar.dart';
import 'package:ssc/presentation/utils/image_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class SignUpAsCustomer extends StatefulWidget {
  const SignUpAsCustomer({super.key});

  @override
  State<SignUpAsCustomer> createState() => _SignUpAsCustomerState();
}

class _SignUpAsCustomerState extends State<SignUpAsCustomer> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$');
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, contain at least one letter, one number, and one special character';
    }
    return null;
  }

  Future<void> _sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${_phoneController.text.trim()}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          CustomSnackbar.showErrorMessage(context, 'The provided phone number is not valid');
        } else if (e.code == 'too-many-requests') {
          CustomSnackbar.showErrorMessage(context, e.message ?? e.code.replaceAll('-', ' '));
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.pushNamed(context, RoutePath.customerPhoneVerificationPage,
            arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      CustomSnackbar.showSuccessMessage(
          context, 'Sending otp to your register mobile number');
      context.read<CustomerSignUpBloc>().add(CustomerSignUpInitiateEvent(
          customerInfo: CustomerInfo(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              phoneNumber: _phoneController.text,
              address: _addressController.text)));
      await _sendOtp();
      // context.read<CustomerSignUpBloc>().add(CustomerSignUpFetchEvent());
    }
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
                  Colors.black.withOpacity(0.6), // Adjust the opacity as needed
                  BlendMode.color,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back))),
                  SizedBox(
                    height: 110.0.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          ImagePath.loginLogo,
                          height: 80.0.h,
                        ),
                        const Text(
                          'Create new account',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _nameController,
                          labelText: 'Name',
                          validator: _validateName,
                          keyboardType: TextInputType.name,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          validator: _validatePassword,
                        ),
                        CustomTextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          labelText: 'Mobile Number',
                          validator: _validateMobileNumber,
                        ),
                        CustomTextField(
                          controller: _addressController,
                          labelText: 'Address',
                          validator: _validateAddress,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async => await _submitForm(),
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
