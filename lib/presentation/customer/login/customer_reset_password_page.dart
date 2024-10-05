import 'package:flutter/material.dart';
import 'package:ssc/presentation/common/custom_text_field.dart';
import 'package:ssc/presentation/utils/common/custom_snackbar.dart';
import 'package:ssc/presentation/utils/image_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class CustomerResetPasswordPage extends StatefulWidget {
  @override
  _CustomerResetPasswordPageState createState() =>
      _CustomerResetPasswordPageState();
}

class _CustomerResetPasswordPageState extends State<CustomerResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (_confirmPasswordController.text != _passwordController.text) {
      return 'Password does not match';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      //TODO: API call
      CustomSnackbar.showSuccessMessage(context, 'Password reset successfully');
      Navigator.pop(context);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back))),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            ImagePath.loginLogo,
                            height: 90.0.h,
                          ),
                          const Text(
                            'Reset password',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.phone,
                            labelText: 'Mobile Number',
                            validator: _validateMobileNumber,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            labelText: 'New Password',
                            validator: _validatePassword,
                          ),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            labelText: 'Confirm Password',
                            validator: _validateConfirmPassword,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Reset Password'),
                            ),
                          ),
                        ],
                      ),
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
