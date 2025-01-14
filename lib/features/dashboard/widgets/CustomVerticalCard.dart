import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/extra/rounded_network_image.dart';
import '../../common/enums/MediaContentType.dart';
import '../../details/screens/DetailsScreen.dart';

class Customverticalcard extends StatelessWidget {
  final int? id;
  final String url;
  final bool isPremium;
  final String? title;
  final MediaContentType mediaContentType;
  final String? seasonId;
  final String? episodeId;
  final bool? episodeRedirect;

  const Customverticalcard({
    super.key,
    required this.isPremium,
    required this.url,
    required this.id,
    required this.title,
    required this.mediaContentType,
    this.episodeId,
    this.episodeRedirect,
    this.seasonId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteConstantName.detailsScreen,
          arguments: DetailsScreenArguments(
            id: id.toString(),
            mediaContentType: mediaContentType,
            seasonId: seasonId,
            episodeId: episodeId,
            episodeRedirect: episodeRedirect,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: [
            RoundedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              width: 115.sp,
              height: 165.sp,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: isPremium // Replace with your boolean variable
                  ? Container(
                      margin: EdgeInsets.all(8.sp),
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
                        padding: EdgeInsets.all(4.sp),
                        child: Image.asset(
                          AssetImages.icSubscribe,
                          width: 14,
                          height: 14,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
