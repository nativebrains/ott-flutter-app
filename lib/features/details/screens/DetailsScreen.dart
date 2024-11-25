import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/core/loader_widget/loader_widget.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCard.dart';
import 'package:islamforever/features/dashboard/widgets/CustomVerticalCard.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../widgets/custom/custom_text.dart';

class DetailsScreenArguments {
  final String title;
  final MediaContentType mediaContentType;

  DetailsScreenArguments({required this.title, required this.mediaContentType});
}

class Detailsscreen extends StatefulWidget {
  final DetailsScreenArguments detailsScreenArguments;
  const Detailsscreen({super.key, required this.detailsScreenArguments});

  @override
  State<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends State<Detailsscreen> {
  int _selectedSeasonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTopSection(),
              SizedBox(height: 8.sp),
              getDescriptionSection(),
              SizedBox(height: 8.sp),
              Divider(height: 1.sp, color: Colors.grey.withOpacity(0.3)),
              SizedBox(height: 16.sp),
              getSeasons(),
              SizedBox(height: 24.sp),
              getEpisodes(),
              SizedBox(height: 24.sp),
              getActors(),
              SizedBox(height: 24.sp),
              getDirectors(),
              SizedBox(height: 24.sp),
              getRelatedMovies(),
              SizedBox(height: 30.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTopSection() {
    return SizedBox(
      height: 240.sp,
      child: Stack(
        children: [
          // Background image
          Image.network(
            'https://cdn.mos.cms.futurecdn.net/eUc7ioQCCUoqXSybUsPeA6-1200-80.jpg',
            fit: BoxFit.cover,
            width: double.infinity, // Set the width to infinity
            height: 235.sp,
          ),

          // Gradient overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 150.sp,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Back icon
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          // Play button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: AvatarGlow(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.pink,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.sp),
                      child: Icon(
                        Icons.play_arrow,
                        size: 45.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDotItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          CustomText(
            text: 'Item ${index + 2}',
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getTrailerWidget() {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(6.sp),
            child: Icon(
              Icons.play_arrow,
              size: 32.sp,
              color: Colors.white,
            ),
          ),
          CustomText(
            text: 'Trailer',
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getAddToMyListWidget() {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(6.sp),
            child: Icon(
              Icons.add,
              size: 32.sp,
              color: Colors.white,
            ),
          ),
          CustomText(
            text: 'My List',
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CustomText(
            text: 'Tom\'s Guide',
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: ColorCode.cardInfoHeader,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: GradientText(
            'IMDB 7.8',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
            colors: [
              Colors.orange,
              Colors.pink,
            ],
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomText(
                    text: 'Nov 02, 1998',
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              ...List.generate(10, (index) => buildDotItem(index)),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(width: 16),
            CustomText(
              text: 'Share :',
              fontSize: 14.sp,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.facebook),
              iconSize: 20.sp,
              color: Colors.blue,
              onPressed: () {
                // Handle Facebook button press
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.twitter),
              color: Colors.blue,
              iconSize: 20.sp,
              onPressed: () {
                // Handle Twitter button press
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.whatsapp),
              color: Colors.green,
              iconSize: 20.sp,
              onPressed: () {
                // Handle WhatsApp button press
              },
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 24.sp),
            getTrailerWidget(),
            SizedBox(width: 24.sp),
            getAddToMyListWidget(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.pink,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Icon(
                    Icons.cast,
                    size: 24.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 28.sp),
          ],
        ),
        SizedBox(
          height: 20.sp,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 20.sp),
              ...List.generate(5, (index) => _buildServerItem(index)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: CustomText(
            text:
                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.',
            color: Colors.grey.shade700,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
            maxLines: 500,
          ),
        ),
      ],
    );
  }

  Widget _buildServerItem(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.only(right: 12.sp),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: 'Server $index',
        fontSize: 14.sp,
        color: Colors.white,
      ),
    );
  }

  Widget getActors() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Actors',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 6.sp),
              ...List.generate(10, (index) => buildActorItem(index)),
            ],
          ),
        )
      ],
    );
  }

  Widget getDirectors() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Director',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 6.sp),
              ...List.generate(10, (index) => buildActorItem(index)),
            ],
          ),
        )
      ],
    );
  }

  Widget buildActorItem(int index) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.sp,
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ZFCyWu6NWupUeYfXszQabRkXWPjzbIr9Cw&s'),
          ),
          SizedBox(height: 10),
          Container(
            width: 70.sp,
            child: TextScroll(
              'Actor/Director $index is a Good One.',
              velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRelatedMovies() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Related Movies',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24.sp),
              ...List.generate(
                10,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Customverticalcard(
                    url:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT978tsS4711GcHRnrEiIp48seju5Q18IBvgw&s",
                    isPremium: false,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getSeasons() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Seasons',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24.sp),
              ...List.generate(
                10,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSeasonIndex = index;
                      });
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: _selectedSeasonIndex == index
                                ? [Colors.orange, Colors.pink]
                                : [ColorCode.cardInfoBg, ColorCode.cardInfoBg],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: CustomText(text: "Season $index")),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getEpisodes() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Episodes',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24.sp),
              ...List.generate(
                10,
                (index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Customhorizontalcard(
                        isPremium: true,
                        showTitle: true,
                        url:
                            "https://anniehaydesign.weebly.com/uploads/9/5/4/6/95469676/landscape-poster-3_orig.jpg")),
              ),
            ],
          ),
        )
      ],
    );
  }
}
