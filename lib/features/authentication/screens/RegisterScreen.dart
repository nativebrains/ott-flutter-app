import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:islamforever/widgets/custom/custom_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_rich_text.dart';
import '../../../widgets/custom/custom_text_field.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  bool _selectedPrivacyAndTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // GIF background
          Image.asset(
            AssetImages.loginBg,
            fit: BoxFit.cover,
          ),
          SafeArea(
            minimum: EdgeInsets.only(left: 24.sp, right: 24.sp, top: 24.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.sp,
                  ),
                  CustomText(
                    text: "Sign Up",
                    color: ColorCode.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp,
                  ),
                  SizedBox(
                    height: 60.sp,
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
                      initialValue: "", // Set the initial value
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        print(value); // Handle the text change
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
                      initialValue: "", // Set the initial value
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        print(value); // Handle the text change
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
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      minLines: 1,
                      maxLines: 1,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        print(value); // Handle the text change
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
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      minLines: 1,
                      maxLines: 1,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        print(value); // Handle the text change
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
                                  ? Colors.pink
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
                                fontSize: 15.sp,
                                leadingTextColor: ColorCode.whiteColor,
                                actionTextColor: Colors.pink,
                                isActionUnderlined: true,
                                onActionTap: () {
                                  // Handle action tap
                                },
                              ),
                              CustomRichText(
                                leadingText: "and ",
                                actionText: "Privacy Policy",
                                fontSize: 15.sp,
                                leadingTextColor: ColorCode.whiteColor,
                                actionTextColor: Colors.pink,
                                isActionUnderlined: true,
                                onActionTap: () {
                                  // Handle action tap
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  CustomElevatedButton(
                    label: 'REGISTER',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteConstantName.dashboardScreen,
                      );
                    },
                    textColor: ColorCode.whiteColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.all(16.0),
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
                          fontSize: 16.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: GradientText(
                          'Login',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                          colors: [
                            Colors.orange,
                            Colors.pink,
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
                            Colors.orange,
                            Colors.pink
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
        ],
      ),
    );
  }
}
