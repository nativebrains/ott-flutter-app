import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/extensions/custom_extensions.dart';
import 'package:islamforever/widgets/custom/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/error_message.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../providers/AuthenticationProvider.dart';

class Forgotpasswordscreen extends StatefulWidget {
  const Forgotpasswordscreen({super.key});

  @override
  State<Forgotpasswordscreen> createState() => _ForgotpasswordscreenState();
}

class _ForgotpasswordscreenState extends State<Forgotpasswordscreen> {
  late AuthenticationProvider authenticationProvider;

  final TextEditingController _emailController = TextEditingController();

  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Forgot your password?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: false,
        ),
      ),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80.sp,
                  ),
                  Text(
                    'Forgot your password?',
                    style: GoogleFonts.poppins(
                      color: ColorCode.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 28.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.sp),
                    child: CustomText(
                      text:
                          'Enter your email address below and we\'ll send you email with password',
                      textAlign: TextAlign.center,
                      color: ColorCode.greyColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
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
                      hintText: 'Enter your email',
                      hintTextColor: Colors.white,
                      controller:
                          _emailController, // Use the TextEditingController
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
                    height: 30.sp,
                  ),
                  CustomElevatedButton(
                    label: 'SEND',
                    onPressed: () {
                      checkAndValidate();
                    },
                    textColor: ColorCode.whiteColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.all(16.0),
                    elevation: 3.sp,
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

  void checkAndValidate() async {
    if (_emailController.text.isEmpty) {
      showCustomToast(context, "Email Missing");
      return;
    }
    if (!_emailController.text.isValidEmail()) {
      showCustomToast(context, "Email not Valid");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    bool success =
        await authenticationProvider.forgotPassword(_emailController.text);

    showCustomToast(
      context,
      AuthenticationProvider.getStatusMessage.toString(),
    );

    setState(() {
      _isLoading = false;
      _emailController.clear(); // Clear the TextEditingController
    });
  }
}
