import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Custombanner extends StatefulWidget {
  const Custombanner({super.key});

  @override
  State<Custombanner> createState() => _CustombannerState();
}

class _CustombannerState extends State<Custombanner> {
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2YH597lrGKw7ZeirxtHWRT4U6JyfGV0a-Vg&s',
    'https://cinema.mu/wp-content/uploads/2019/07/banner-films.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC6EzCemijWUzMhioIQ8B-S-vMTagfJmyF0g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREa6KX__FA_L5uuNWEuhs0KPZk0lJxexuHLw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7KQecaVoxTT2wf7t7q4IqHaOcKpbRIvjayw&s',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.2,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
        ),
        items: imgList
            .map(
              (item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child:
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
