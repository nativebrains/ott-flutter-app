import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/extensions/custom_extensions.dart';
import 'package:islamforever/features/webview/screens/WebviewScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:islamforever/widgets/custom/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/error_message.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_rich_text.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../providers/AuthenticationProvider.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  late AuthenticationProvider authenticationProvider;
  bool _selectedPrivacyAndTerms = false;

  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  CustomText(
                    text: "Sign Up",
                    color: ColorCode.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                  SizedBox(
                    height: 40.sp,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.sp, horizontal: 6.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: ColorCode.inputBgColor),
                      color: ColorCode.inputBgColor,
                    ),
                    child: CustomTextField(
                      hintText: 'Name',
                      hintTextColor: Colors.white,
                      initialValue: name, // Set the initial value
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        print(value); // Handle the text change
                        name = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.sp, horizontal: 6.sp),
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
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        print(value); // Handle the text change
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.sp, horizontal: 6.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: ColorCode.inputBgColor),
                      color: ColorCode.inputBgColor,
                    ),
                    child: CustomTextField(
                      hintText: 'Password',
                      hintTextColor: Colors.white,
                      keyboardType: TextInputType.text,
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
                    height: 20.sp,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.sp, horizontal: 6.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: ColorCode.inputBgColor),
                      color: ColorCode.inputBgColor,
                    ),
                    child: CustomTextField(
                      hintText: 'Confirm Password',
                      hintTextColor: Colors.white,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      initialValue: confirmPassword,
                      minLines: 1,
                      maxLines: 1,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        print(value); // Handle the text change
                        confirmPassword = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
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
                                  Navigator.pushNamed(
                                      context, RouteConstantName.webviewScreen,
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
                                  Navigator.pushNamed(
                                      context, RouteConstantName.webviewScreen,
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
                    height: 50.sp,
                  ),
                  CustomElevatedButton(
                    label: 'REGISTER',
                    onPressed: () async {
                      if (_selectedPrivacyAndTerms) {
                        await checkAndValidateForRegister();
                      } else {
                        showCustomToast(
                            context, "Please accept Terms and Privacry Policy");
                      }
                    },
                    textColor: ColorCode.whiteColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.all(14.sp),
                    elevation: 3.sp,
                  ),
                  SizedBox(
                    height: 40.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account? ',
                        style: GoogleFonts.poppins(
                          color: ColorCode.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: GradientText(
                          'Login',
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
                          begin: Alignment.centerLeft, // Start of the gradient
                          end: Alignment.centerRight, // End of the gradient
                        ),

                        borderRadius:
                            BorderRadius.circular(12), // Corner radius
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.sp,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) const LoaderWidget(),
        ],
      ),
    );
  }

  Future<void> checkAndValidateForRegister() async {
    if (name == null) {
      showCustomToast(context, "Name is Missing");
      return;
    }
    if (email == null) {
      showCustomToast(context, "Email is Missing");
      return;
    }
    if (!email!.isValidEmail()) {
      showCustomToast(context, "Email not Valid");
      return;
    }
    if (password == null) {
      showCustomToast(context, "Password is Missing");
      return;
    }
    if (confirmPassword == null) {
      showCustomToast(context, "Confirm Password is Missing");
      return;
    }
    if (password != confirmPassword) {
      showCustomToast(context, "Confirm Password Not Matched");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    bool success =
        await authenticationProvider.register(name!, email!, password!);

    showCustomToast(context, AuthenticationProvider.getStatusMessage.toString(),
        backgroudnColor: success ? Colors.green : Colors.red);

    setState(() {
      _isLoading = false;
    });
    if (success) {
      Navigator.of(context).pop();
    }
  }
}
