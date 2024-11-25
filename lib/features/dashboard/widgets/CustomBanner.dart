import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islamforever/constants/routes_names.dart';

import '../../common/enums/MediaContentType.dart';
import '../../details/screens/DetailsScreen.dart';

class Custombanner extends StatefulWidget {
  final List<String> imgList;
  const Custombanner({super.key, required this.imgList});

  @override
  State<Custombanner> createState() => _CustombannerState();
}

class _CustombannerState extends State<Custombanner> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.1,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items: widget.imgList
          .map(
            (item) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteConstantName.detailsScreen,
                  arguments: DetailsScreenArguments(
                    title: "Banner",
                    mediaContentType: MediaContentType.movies,
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
