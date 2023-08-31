// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inkflow_app/src/res/helper_functions.dart';
import 'package:flutter_inkflow_app/src/res/strings.dart';
import 'package:flutter_inkflow_app/src/services/auth_services.dart';
import 'package:flutter_inkflow_app/src/services/database_service.dart';
import 'package:flutter_inkflow_app/src/views/home.dart';
import 'package:flutter_inkflow_app/src/views/widgets/custom_button.dart';
import 'package:flutter_inkflow_app/src/views/widgets/custom_loading_button.dart';
import 'package:flutter_inkflow_app/src/views/widgets/logo_container.dart';
import 'package:flutter_inkflow_app/src/views/widgets/or_divider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const LoginScreen(),
    );
  }

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  String email = "";
  final formKey = GlobalKey<FormState>();
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoContainer(),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "LOGIN TO INKFLOW",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "Welcome back, Login to continue",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16.sp),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.20),
                        hintText: "Email",
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  // color: Colors.grey.withAlpha(190),
                                ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },

                      // check tha validation
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16.sp),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.20),
                        hintText: "Password",
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  // color: Colors.grey.withAlpha(190),
                                ),
                      ),
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _isLoading
                        ? CustomGradientLoadingButton(onpress: () {})
                        : CustomGradientButton(
                            onpress: login, buttonLabel: "LOGIN"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  const OrDivider(),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundedLoadingButton(
                    valueColor: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {
                      loginWithGoogle();
                    },
                    controller: googleController,
                    successColor: Theme.of(context).colorScheme.onPrimary,
                    width: MediaQuery.of(context).size.width * 0.80,
                    elevation: 0,
                    borderRadius: 10.r,
                    color: Colors.grey.withOpacity(0.20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h)
                              .copyWith(right: 10.w),
                          child: Image.asset("assets/images/google.png"),
                        ),
                        Text(
                          "Sign in with Google",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text(
                    "Register",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // This function will help user login with username and password
  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          // saving the values to our shared preferences

          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          Navigator.pushReplacementNamed(
            context,
            HomeView.routeName,
          );
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  // This function will help user login with google
  loginWithGoogle() async {
    await AuthService().signInWithGoogle();

    await HelperFunctions.saveUserLoggedInStatus(true);
    Navigator.pushReplacementNamed(
      context,
      HomeView.routeName,
    );
    setState(() {
      _isLoading = false;
    });
  }
}
