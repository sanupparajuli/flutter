import 'package:flutter/material.dart';
import 'package:one_in_million/models/video_data.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/widgets/responsive.dart';

class VideoCard extends StatelessWidget {
  const VideoCard(
    BuildContext context, {
    super.key,
    this.videoData,
  });

  final VideoData? videoData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width(100, context) * 31,
      margin: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(videoData!.logo!),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: AppColor.iconBlue,
          ),
          child: Text(
            videoData!.title!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
