import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamforever/extensions/custom_extensions.dart';
import 'package:islamforever/features/account/models/ItemDashboardModel.dart';
import 'package:islamforever/features/settings/screens/AboutScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/error_message.dart';
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
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userPhoneController = TextEditingController();

  XFile? _selectedImage; // Store the picked image
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProfileDetails();
    });
  }

  void fetchProfileDetails() async {
    if (AccountProvider.isLoggedIn) {
      ItemDashBoardModel? itemDashBoardModel =
          await accountProvider.fetchProfileDetails();
      _userNameController.text = itemDashBoardModel!.userName.toString();
      _userEmailController.text = itemDashBoardModel.userEmail.toString();
      _userPhoneController.text = itemDashBoardModel.userPhone.toString();
    }
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Storing selected Image
      setState(() {
        _selectedImage = image;
      });

      showCustomToast(
        context,
        "Image Picked",
        backgroudnColor: Colors.green,
      );
    } else {
      showCustomToast(
        context,
        "No Image Selected",
        backgroudnColor: Colors.yellow,
        duration: Duration(seconds: 3),
        textColor: Colors.black,
      );
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
                      colors: [
                        ColorCode.greenStartColor,
                        ColorCode.greenEndColor
                      ],
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 110.sp),
              child: Center(
                child: InkWell(
                  onTap: _pickImage,
                  child: SizedBox(
                    width: 80.sp,
                    height: 80.sp,
                    child: Stack(
                      children: [
                        // Display the selected image or the network image
                        _selectedImage != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(
                                  File(_selectedImage!.path),
                                ),
                              )
                            : RoundedNetworkImage(
                                imageUrl: accountProvider
                                        .itemDashBoardModel?.userImage ??
                                    "",
                                fit: BoxFit.cover,
                                width: 80.sp,
                                height: 80.sp,
                                borderRadius: 50,
                              ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(
                            Icons.add_photo_alternate,
                            color: ColorCode.greenStartColor,
                          ),
                        ),
                      ],
                    ),
                  ),
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
          controller: _userNameController,
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
          controller: _userEmailController,
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
          controller: _userPasswordController,
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
          controller: _userPhoneController,
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
              _updateUserProfile(() {
                Navigator.of(context).pop();
              });
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

  void _updateUserProfile(Function callback) async {
    String userName = _userNameController.text;
    String userEmail = _userEmailController.text;
    String userPassword = _userPasswordController.text;
    String userPhone = _userPhoneController.text;

    if (userName.isEmpty) {
      showCustomToast(context, "Username is missing",
          backgroudnColor: Colors.red);
      return;
    }

    if (userEmail.isEmpty) {
      showCustomToast(context, "Email is Missing");
      return;
    }
    if (!userEmail.isValidEmail()) {
      showCustomToast(context, "Email not Valid");
      return;
    }
    if (userPassword.isEmpty ||
        (userPassword.isNotEmpty && userPassword.length <= 5)) {
      showCustomToast(context, "Password is invalid",
          backgroudnColor: Colors.red);
      return;
    }
    if (userPhone.isEmpty) {
      showCustomToast(context, "Phone is Missing");
      return;
    }

    bool isSuccess = await accountProvider.updateUserProfile(
      userName,
      userEmail,
      userPassword,
      userPhone,
      _selectedImage != null ? File(_selectedImage!.path) : null,
    );

    showCustomToast(context, AccountProvider.statusMessage,
        backgroudnColor: isSuccess ? Colors.green : Colors.red);
    if (isSuccess) {
      fetchProfileDetails();
    }
  }
}
