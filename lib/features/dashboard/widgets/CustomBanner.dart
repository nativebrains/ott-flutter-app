import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islamforever/constants/routes_names.dart';
import 'package:islamforever/features/dashboard/models/ItemSliderModel.dart';

import '../../../widgets/extra/rounded_network_image.dart';
import '../../common/enums/MediaContentType.dart';
import '../../details/screens/DetailsScreen.dart';

class Custombanner extends StatefulWidget {
  final List<ItemSliderModel> itemSliderList;
  const Custombanner({super.key, required this.itemSliderList});

  @override
  State<Custombanner> createState() => _CustombannerState();
}

class _CustombannerState extends State<Custombanner> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 1.9,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
      items: widget.itemSliderList
          .map(
            (item) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteConstantName.detailsScreen,
                  arguments: DetailsScreenArguments(
                    id: item.sliderPostId.toString(),
                    mediaContentType: item.mediaContentType,
                  ),
                );
              },
              child: RoundedNetworkImage(
                imageUrl: item.sliderImage ?? "",
                fit: BoxFit.cover,
                width: 1000,
                height: 1000,
              ),
            ),
          )
          .toList(),
    );
  }
}
