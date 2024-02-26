import 'package:flutter/material.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/widgets/responsive.dart';
import 'package:readmore/readmore.dart';

class NewsFeedCard extends StatelessWidget {
  const NewsFeedCard(
    BuildContext context, {
    super.key,
    required this.count,
    required this.image,
    required this.title,
    required this.text,
  });
  final String image;
  final String count;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    const double imageWidth = 20.0;
    const double imageHeight = 10.0;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color.fromARGB(40, 70, 94, 255)),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                image,
                width: Responsive.width(100, context) * imageWidth,
                height: Responsive.height(100, context) * imageHeight,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(40, 67, 92, 251),
                    ),
                    child: Text(
                      count + title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.width(100, context) * 65,
                    child: ReadMoreText(
                      text + '  ',
                      textAlign: TextAlign.start,
                      trimLines: 3,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Show less',
                      moreStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColor.iconBlue),
                      lessStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColor.iconBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
