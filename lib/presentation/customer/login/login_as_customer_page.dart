import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/customer_login/customer_login_bloc.dart';
import 'package:ssc/presentation/common/custom_text_field.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/common/loading_shimmer.dart';
import 'package:ssc/presentation/utils/image_path.dart';

class LoginAsCustomer extends StatefulWidget {
  const LoginAsCustomer({super.key});

  @override
  State<LoginAsCustomer> createState() => _LoginAsCustomerState();
}

class _LoginAsCustomerState extends State<LoginAsCustomer> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
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
      return 'Please enter your password';
    } else if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, contain at least one letter, one number, and one special character';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      context.read<CustomerLoginBloc>().add(CustomerLoginFetchEvent(
          mobileNumber: _phoneNumberController.text,
          password: _passwordController.text));
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
                  Colors.black
                      .withOpacity(0.6), // Adjust the opacity as needed
                  BlendMode.color,
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.arrow_back),
                              ),
                            ),
                            Expanded(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      ImagePath.loginLogo,
                                      height: 100.0,
                                    ),
                                    Text(
                                      'Customer login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      controller: _phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      labelText: 'Mobile Number',
                                      validator: _validateMobileNumber,
                                    ),
                                    CustomTextField(
                                      controller: _passwordController,
                                      labelText: 'Password',
                                      validator: _validatePassword,
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context,
                                          RoutePath
                                              .customerResetPasswordPage),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            decorationColor: Colors.white,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    BlocBuilder<CustomerLoginBloc,
                                        CustomerLoginState>(
                                      builder: (context, state) {
                                        return LoadingShimmer.withChild(
                                          enabled: state.isLoading,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () async =>
                                                  await _submitForm(),
                                              child: const Text('Submit'),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context,
                                          RoutePath.signUpAsCustomerPage),
                                      child: Text(
                                        'Create an new account',
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.underline,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decorationColor: Colors.white,
                                        ),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
