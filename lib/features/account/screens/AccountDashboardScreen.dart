import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/purchase/models/ItemTransactionModel.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../../widgets/extra/rounded_network_image.dart';
import '../providers/AccountProvider.dart';

class AccountDashboardScreen extends StatefulWidget {
  const AccountDashboardScreen({super.key});

  @override
  State<AccountDashboardScreen> createState() => _AccountDashboardScreenState();
}

class _AccountDashboardScreenState extends State<AccountDashboardScreen> {
  late AccountProvider accountProvider;

  @override
  void initState() {
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    if (AccountProvider.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        accountProvider.fetchDashboardAccountDetails(refresh: true);
      });
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
                  "Dashbaord",
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
                      if (!accountProvider.isLoading)
                        if (AccountProvider.isLoggedIn) getDashboardData()
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

  Widget getDashboardData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.sp,
        ),
        getUserProfileCard(),
        SizedBox(
          height: 20.sp,
        ),
        getMemberShipCard(),
        SizedBox(
          height: 20.sp,
        ),
        getLastInvoiceCard(),
        SizedBox(
          height: 20.sp,
        ),
        getUserTransactionCards(),
        SizedBox(
          height: 20.sp,
        ),
      ],
    );
  }

  Widget getUserTransactionCards() {
    if (accountProvider.itemDashBoardModel == null ||
        accountProvider.itemDashBoardModel?.transactionsList?.isEmpty == true) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.sp,
          ),
          CustomText(
            text: "User Transactions",
            color: ColorCode.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
          SizedBox(
            height: 12.sp,
          ),
          if (accountProvider.itemDashBoardModel!.transactionsList != null)
            ...List.generate(
              accountProvider.itemDashBoardModel!.transactionsList!.length,
              (index) => getTransactionCard(
                  accountProvider.itemDashBoardModel!.transactionsList![index]),
            ),
        ],
      ),
    );
  }

  Widget getTransactionCard(ItemTransactionModel transactionItem) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.sp),
      decoration: BoxDecoration(
        color: ColorCode.cardInfoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCode.cardInfoBg,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), // Rounded top-left corner
                topRight: Radius.circular(10), // Rounded top-right corner
              ),
            ),
            child: CustomText(
              text: transactionItem.planName ?? "",
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          Divider(
            height: 1.sp,
            color: Colors.grey.shade800,
          ),
          SizedBox(
            height: 16.sp,
          ),
          getPlanRow(
            "Payment Date",
            transactionItem.paymentDate ?? "",
          ),
          SizedBox(
            height: 8.sp,
          ),
          getPlanRow(
            "Amount",
            transactionItem.planAmount ?? "",
          ),
          SizedBox(
            height: 8.sp,
          ),
          getPlanRow(
            "Payment Gateway",
            transactionItem.paymentGateway ?? "",
          ),
          SizedBox(
            height: 8.sp,
          ),
          getPlanRow("Transaction ID", transactionItem.paymentId ?? ""),
          SizedBox(
            height: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget getPlanRow(String first, String second) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: CustomText(
              text: first,
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 6.sp,
          ),
          Expanded(
            flex: 1,
            child: CustomText(
              text: second,
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget getLastInvoiceCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorCode.cardInfoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCode.cardInfoHeader,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), // Rounded top-left corner
                topRight: Radius.circular(10), // Rounded top-right corner
              ),
            ),
            child: Center(
              child: CustomText(
                text: "Last Invoice",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
          Divider(
            height: 1.sp,
            color: Colors.grey.shade800,
          ),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset(
                  "assets/images/wave_bg.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 16.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.sp,
                      ),
                      CustomText(
                        text: "Date : ",
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 6.sp),
                        decoration: BoxDecoration(
                          color: ColorCode.cardInfoHighlight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomText(
                          text: accountProvider.itemDashBoardModel
                                      ?.lastInvoiceDate?.isEmpty ??
                                  true
                              ? "N/A"
                              : accountProvider
                                      .itemDashBoardModel?.lastInvoiceDate ??
                                  "N/A",
                          color: ColorCode.whiteColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.sp,
                      ),
                      CustomText(
                        text: "Plan : ",
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 6.sp),
                        decoration: BoxDecoration(
                          color: ColorCode.cardInfoHighlight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomText(
                          text: accountProvider.itemDashBoardModel
                                      ?.lastInvoicePlan?.isEmpty ??
                                  true
                              ? "N/A"
                              : accountProvider
                                      .itemDashBoardModel?.lastInvoicePlan ??
                                  "N/A",
                          color: ColorCode.whiteColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.sp,
                      ),
                      CustomText(
                        text: "Amount : ",
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 6.sp),
                        decoration: BoxDecoration(
                          color: ColorCode.cardInfoHighlight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomText(
                          text: accountProvider.itemDashBoardModel
                                      ?.lastInvoiceAmount?.isEmpty ??
                                  true
                              ? "N/A"
                              : accountProvider
                                      .itemDashBoardModel?.lastInvoiceAmount ??
                                  "N/A",
                          color: ColorCode.whiteColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getMemberShipCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorCode.cardInfoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCode.cardInfoHeader,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), // Rounded top-left corner
                topRight: Radius.circular(10), // Rounded top-right corner
              ),
            ),
            child: Center(
              child: CustomText(
                text: "My Subscription",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
          Divider(
            height: 1.sp,
            color: Colors.grey.shade800,
          ),
          Stack(children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                "assets/images/wave_bg.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.sp,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 24.sp,
                    ),
                    CustomText(
                      text: "Current Plan : ",
                      color: ColorCode.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 6.sp),
                      decoration: BoxDecoration(
                        color: ColorCode.cardInfoHighlight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CustomText(
                        text: accountProvider
                                    .itemDashBoardModel?.currentPlan?.isEmpty ??
                                true
                            ? "N/A"
                            : accountProvider.itemDashBoardModel?.currentPlan ??
                                "N/A",
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: CustomText(
                    text: accountProvider
                                .itemDashBoardModel?.expiresOn?.isEmpty ??
                            true
                        ? "Subscription expires on N/A"
                        : ("Subscription expires on ${accountProvider.itemDashBoardModel!.expiresOn}"),
                    color: ColorCode.whiteColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 16.sp,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomElevatedButton(
                    label: 'Upgrade Plan',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteConstantName.subscriptionPlanScreen,
                      );
                    },
                    textColor: ColorCode.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    padding: EdgeInsets.all(12.0),
                    borderRadius: 50,
                    elevation: 3.sp,
                    width: 160.sp,
                  ),
                ),
                SizedBox(
                  height: 16.sp,
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }

  Widget getUserProfileCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorCode.cardInfoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCode.cardInfoHeader,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), // Rounded top-left corner
                topRight: Radius.circular(10), // Rounded top-right corner
              ),
            ),
            child: Center(
              child: CustomText(
                text: "User Profile",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
          Divider(
            height: 1.sp,
            color: Colors.grey.shade800,
          ),
          Stack(children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                "assets/images/wave_bg.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 16.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 24.sp),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.greenAccent, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: RoundedNetworkImage(
                        imageUrl:
                            accountProvider.itemDashBoardModel?.userImage ?? "",
                        fit: BoxFit.cover,
                        width: 60.sp,
                        height: 60.sp,
                        borderRadius: 50,
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: accountProvider
                                      .itemDashBoardModel?.userName ??
                                  "",
                              color: ColorCode.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                            TextScroll(
                              accountProvider.itemDashBoardModel?.userEmail ??
                                  "",
                              velocity:
                                  Velocity(pixelsPerSecond: Offset(30, 0)),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    CustomElevatedButton(
                      label: 'Edit',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteConstantName.profileScreen,
                        );
                      },
                      textColor: ColorCode.whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      padding: EdgeInsets.all(8.0),
                      elevation: 3.sp,
                      borderRadius: 50,
                      width: 60,
                    ),
                    SizedBox(width: 24.sp),
                  ],
                ),
                SizedBox(
                  height: 16.sp,
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  Widget customContainer(Widget child, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 6.sp),
        decoration: BoxDecoration(
          color: ColorCode.cardInfoHeader,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
