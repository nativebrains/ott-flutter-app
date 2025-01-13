
// class CustomReviewItem extends StatefulWidget {
//   ReviewRatingModel reviewRatingModel;
//   CustomReviewItem({super.key, required this.reviewRatingModel});

//   @override
//   State<CustomReviewItem> createState() => _CustomReviewItemState();
// }

// class _CustomReviewItemState extends State<CustomReviewItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: RoundedNetworkImage(
//                       imageUrl: widget.reviewRatingModel.author.avatar,
//                       width: 57.sp,
//                       height: 57.sp,
//                       borderRadius: 50.sp,
//                     ),
//                   ),
//                   Positioned(
//                     top: 3,
//                     right: 3,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 2.sp,
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                       child: CircleAvatar(
//                         radius: 8.sp,
//                         backgroundColor: Colors
//                             .transparent, // Optional: Set background color
//                         backgroundImage: NetworkImage(
//                           widget.reviewRatingModel.author.flag,
//                         ),
//                         onBackgroundImageError: (exception, stackTrace) {
//                           // Handle the error by displaying a fallback image or widget
//                           print('Error loading flag image: $exception');
//                         },
//                         child: widget.reviewRatingModel.author.flag == null
//                             ? Icon(Icons.error,
//                                 size: 6.sp) // Fallback icon or widget
//                             : null,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 width: 12.sp,
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: widget.reviewRatingModel.author.name,
//                       fontSize: 18.sp,
//                       textAlign: TextAlign.start,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     CustomText(
//                       text: widget.reviewRatingModel.author.role,
//                       fontSize: 12.sp,
//                       textAlign: TextAlign.start,
//                       color: ColorCode.greyLightTextColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: 12.sp,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 12.0),
//                 child: RatingBar(
//                   initialRating: widget.reviewRatingModel.rating.toDouble(),
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 20.sp,
//                   ignoreGestures: true,
//                   ratingWidget: RatingWidget(
//                     full:
//                         Icon(Icons.star_rounded, color: Colors.yellow.shade600),
//                     half:
//                         Icon(Icons.star_rounded, color: Colors.yellow.shade600),
//                     empty:
//                         Icon(Icons.star_rounded, color: Colors.grey.shade400),
//                   ),
//                   onRatingUpdate: (rating) {
//                     print(rating);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 12.sp,
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: CustomText(
//               text: widget.reviewRatingModel.content,
//               fontSize: 14.sp,
//               textAlign: TextAlign.start,
//               color: ColorCode.greyLightTextColor,
//             ),
//           ),
//           SizedBox(
//             height: 20.sp,
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.calendar_month,
//                 size: 17.sp,
//                 color: Colors.grey.withOpacity(0.5),
//               ),
//               SizedBox(
//                 width: 12.sp,
//               ),
//               CustomText(
//                 text: formatDate(
//                     DateTime.parse(
//                       widget.reviewRatingModel.createdAt,
//                     ),
//                     "EEE, dd MMM yyyy hh:mm a"),
//                 fontSize: 10.sp,
//                 textAlign: TextAlign.start,
//                 color: ColorCode.greyLightTextColor,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 12.sp,
//           ),
//         ],
//       ),
//     );
//   }
// }
