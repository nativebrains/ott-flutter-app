import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/settings/screens/AboutScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../../widgets/custom/custom_text_field.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with snapping and floating behavior
          SliverAppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: false,
            floating: true,
            snap: true,
            expandedHeight: 55.0, // Set height for expanded AppBar
          ),
          // SliverList for your content
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.sp,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/profile_bg.png",
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 150.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 110.sp),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 32,
                            backgroundImage:
                                AssetImage(AssetImages.dawateIslamiLogo),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomText(
                      text: "Name :-",
                      color: ColorCode.greyColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Name',
                    hintTextColor: Colors.white,
                    initialValue: "", // Set the initial value
                    keyboardType: TextInputType.text,
                    fillColor: Colors.transparent,
                    onChanged: (value) {
                      print(value); // Handle the text change
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4),
                    child: Divider(
                      height: 1.sp,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomText(
                      text: "Email :-",
                      color: ColorCode.greyColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Email',
                    hintTextColor: Colors.white,
                    initialValue: "", // Set the initial value
                    keyboardType: TextInputType.emailAddress,
                    fillColor: Colors.transparent,
                    onChanged: (value) {
                      print(value); // Handle the text change
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4),
                    child: Divider(
                      height: 1.sp,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomText(
                      text: "Password :-",
                      color: ColorCode.greyColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    hintTextColor: Colors.white,
                    initialValue: "", // Set the initial value
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    minLines: 1,
                    maxLines: 1,
                    fillColor: Colors.transparent,
                    onChanged: (value) {
                      print(value); // Handle the text change
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4),
                    child: Divider(
                      height: 1.sp,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomText(
                      text: "Phone :-",
                      color: ColorCode.greyColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Phone',
                    hintTextColor: Colors.white,
                    initialValue: "", // Set the initial value
                    keyboardType: TextInputType.number,

                    fillColor: Colors.transparent,
                    onChanged: (value) {
                      print(value); // Handle the text change
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4),
                    child: Divider(
                      height: 1.sp,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: CustomElevatedButton(
                      label: 'SAVE PROFILE',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      textColor: ColorCode.whiteColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      padding: EdgeInsets.all(16.0),
                      elevation: 3.sp,
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
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
