import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/core/loader_widget/loader_widget.dart';
import 'package:islamforever/extensions/custom_extensions.dart';
import 'package:islamforever/features/authentication/providers/AuthenticationProvider.dart';
import 'package:islamforever/routes/routes.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/assets_images.dart';
import '../../../constants/error_message.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_radio_button_toggle.dart';
import '../../../widgets/custom/custom_rich_text.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../../webview/screens/WebviewScreen.dart';

class Authenticationscreen extends StatefulWidget {
  const Authenticationscreen({super.key});

  @override
  State<Authenticationscreen> createState() => _AuthenticationscreenState();
}

class _AuthenticationscreenState extends State<Authenticationscreen> {
  late AuthenticationProvider authenticationProvider;
  bool _selectedRemeberMe = false;
  bool _selectedPrivacyAndTerms = false;

  String? email;
  String? password;
  var _isLoading = false;
  DateTime? lastBackPressed;

  @override
  void initState() {
    super.initState();
    authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
          lastBackPressed = now;
          Fluttertoast.showToast(
            msg: 'Please click BACK again to exit',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: ColorCode.greenStartColor,
            textColor: Colors.white,
            fontSize: 15.sp,
          );
          return false; // Do not exit the app
        }
        exit(0); // Exit the app
      },
      child: Scaffold(
        backgroundColor: ColorCode.scaffoldBackgroundColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // GIF background
            Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage(AssetImages.loginBg),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            SafeArea(
              minimum: EdgeInsets.only(left: 24.sp, right: 24.sp, top: 24.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in to continue',
                          style: GoogleFonts.poppins(
                            color: ColorCode.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteConstantName.dashboardScreen,
                            );
                          },
                          child: GradientText(
                            'Skip',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w900),
                            colors: const [
                              ColorCode.greenStartColor,
                              ColorCode.greenEndColor,
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.sp, horizontal: 6.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: ColorCode.inputBgColor),
                        color: ColorCode.inputBgColor,
                      ),
                      child: CustomTextField(
                        hintText: 'Email',
                        hintTextColor: Colors.white,
                        initialValue: email, // Set the initial value
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          print(value); // Handle the text change
                          email = value;
                        },
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.sp, horizontal: 6.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: ColorCode.inputBgColor),
                        color: ColorCode.inputBgColor,
                      ),
                      child: CustomTextField(
                        hintText: 'Password',
                        hintTextColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        initialValue: password,
                        minLines: 1,
                        maxLines: 1,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          print(value); // Handle the text change
                          password = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButtonToggle(
                          value: _selectedRemeberMe,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedRemeberMe = newValue; // Update state
                            });
                          },
                          text: 'Remember me',
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteConstantName.forgotPasswordScreen,
                            );
                          },
                          child: CustomText(
                            text: "Forgot password?",
                            fontSize: 14.sp,
                            textAlign: TextAlign.start,
                            color: ColorCode.whiteColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.sp,
                    ),
                    Container(
                      width: context.screenWidth,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPrivacyAndTerms =
                                    !_selectedPrivacyAndTerms;
                              });
                            },
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: _selectedPrivacyAndTerms
                                    ? Colors.greenAccent
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    4), // Square with rounded edges
                              ),
                              child: _selectedPrivacyAndTerms
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(
                            width: 16.sp,
                          ),
                          Flexible(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 10, // Space between widgets horizontally
                              runSpacing: 5,
                              children: [
                                CustomRichText(
                                  leadingText: "By signing in you accept to ",
                                  actionText: "Terms",
                                  fontSize: 14.sp,
                                  leadingTextColor: ColorCode.whiteColor,
                                  actionTextColor: Colors.greenAccent,
                                  isActionUnderlined: true,
                                  onActionTap: () {
                                    Navigator.pushNamed(context,
                                        RouteConstantName.webviewScreen,
                                        arguments: const WebviewScreen(
                                            webviewType: WebviewType.TERMS));
                                  },
                                ),
                                CustomRichText(
                                  leadingText: "and ",
                                  actionText: "Privacy Policy",
                                  fontSize: 14.sp,
                                  leadingTextColor: ColorCode.whiteColor,
                                  actionTextColor: Colors.greenAccent,
                                  isActionUnderlined: true,
                                  onActionTap: () {
                                    Navigator.pushNamed(context,
                                        RouteConstantName.webviewScreen,
                                        arguments: const WebviewScreen(
                                            webviewType: WebviewType.PRIVACY));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60.sp,
                    ),
                    CustomElevatedButton(
                      label: 'LOGIN',
                      onPressed: () async {
                        if (_selectedPrivacyAndTerms) {
                          await checkAndValidateForLogin();
                        } else {
                          showCustomToast(context,
                              "Please accept Terms and Privacry Policy");
                        }
                      },
                      textColor: ColorCode.whiteColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      padding: EdgeInsets.all(14.sp),
                      elevation: 3.sp,
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: CustomText(
                    //     text: "Or Continue with",
                    //     fontSize: 16.sp,
                    //     textAlign: TextAlign.center,
                    //     color: ColorCode.whiteColor,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30.sp,
                    // ),
                    // TextButton(
                    //   onPressed: () {
                    //     // Add your onPressed functionality here
                    //   },
                    //   style: TextButton.styleFrom(
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 10, vertical: 12), // Adjust padding
                    //     backgroundColor: Colors.red, // Button background color
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8), // Corner radius
                    //     ),
                    //   ),
                    //   child: const Row(
                    //     mainAxisAlignment: MainAxisAlignment
                    //         .spaceBetween, // Align items to the start
                    //     children: [
                    //       Text(
                    //         ' G', // Initial or icon text
                    //         style: TextStyle(
                    //           fontSize: 28, // Icon size
                    //           color: Colors.white, // Icon color
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       // Space between icon and text
                    //       Text(
                    //         'Google', // Button text
                    //         style: TextStyle(
                    //           fontSize: 20, // Text size
                    //           color: Colors.white, // Text color
                    //         ),
                    //       ),
                    //       SizedBox(width: 24),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 50.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an Account? ',
                          style: GoogleFonts.poppins(
                            color: ColorCode.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteConstantName.registerScreen,
                            );
                          },
                          child: GradientText(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                            colors: const [
                              ColorCode.greenStartColor,
                              ColorCode.greenEndColor
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Center(
                      child: Container(
                        height: 4.0, // Height of the line
                        width: context.screenWidth / 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorCode.greenStartColor,
                              ColorCode.greenEndColor
                            ], // Start and end colors of the gradient
                            begin:
                                Alignment.centerLeft, // Start of the gradient
                            end: Alignment.centerRight, // End of the gradient
                          ),

                          borderRadius:
                              BorderRadius.circular(12), // Corner radius
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.sp,
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  Future<void> checkAndValidateForLogin() async {
    if (email == null) {
      showCustomToast(context, "Email Missing");
      return;
    }
    if (!email!.isValidEmail()) {
      showCustomToast(context, "Email not Valid");
      return;
    }
    if (password == null) {
      showCustomToast(context, "Password Missing");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    bool success = await authenticationProvider.login(
        _selectedRemeberMe, email!, password!);

    showCustomToast(context, AuthenticationProvider.getStatusMessage.toString(),
        backgroudnColor: success ? Colors.green : Colors.red);

    setState(() {
      _isLoading = false;
    });
    if (success) {
      Navigator.pushReplacementNamed(
        context,
        RouteConstantName.dashboardScreen,
      );
    }
  }
}
