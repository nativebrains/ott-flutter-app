import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/settings/screens/AboutScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../../../widgets/extra/rounded_network_image.dart';
import '../providers/AccountProvider.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  late AccountProvider accountProvider;

  @override
  void initState() {
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    if (AccountProvider.isLoggedIn) {
      accountProvider.fetchProfileDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: Stack(
        children: [
          CustomScrollView(
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
                      if (!accountProvider.isLoading &&
                          AccountProvider.isLoggedIn)
                        getProfileDetails(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (accountProvider.isLoading) const LoaderWidget(),
        ],
      ),
    );
  }

  Widget getProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              child: Center(
                child: RoundedNetworkImage(
                  imageUrl: accountProvider.itemDashBoardModel?.userImage ?? "",
                  fit: BoxFit.cover,
                  width: 75.sp,
                  height: 75.sp,
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
          hintText: accountProvider.itemDashBoardModel?.userName ?? "",
          hintTextColor: Colors.white,
          initialValue: accountProvider.itemDashBoardModel?.userName ?? "",
          keyboardType: TextInputType.text,
          fillColor: Colors.transparent,
          onChanged: (value) {
            print(value); // Handle the text change
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
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
          hintText: accountProvider.itemDashBoardModel?.userEmail ?? "",
          hintTextColor: Colors.white,
          initialValue: accountProvider.itemDashBoardModel?.userEmail ?? "",
          keyboardType: TextInputType.emailAddress,
          fillColor: Colors.transparent,
          onChanged: (value) {
            print(value); // Handle the text change
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
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
          hintText: accountProvider.itemDashBoardModel?.userPhone ?? "",
          hintTextColor: Colors.white,
          initialValue: accountProvider.itemDashBoardModel?.userPhone ?? "",
          keyboardType: TextInputType.number,
          fillColor: Colors.transparent,
          onChanged: (value) {
            print(value); // Handle the text change
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
          child: Divider(
            height: 1.sp,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        SizedBox(
          height: 50.sp,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: CustomElevatedButton(
            label: 'Save Profile',
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
    );
  }
}
