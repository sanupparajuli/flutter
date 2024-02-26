// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/models/news_data.dart';
import 'package:one_in_million/models/video_data.dart';
import 'package:one_in_million/screens/ourvision.dart';
import 'package:one_in_million/screens/video_player.dart';
import 'package:one_in_million/services/firestore_data.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/internet_connectivity.dart';
import 'package:one_in_million/utils/message_notifier.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/horizontal_logo.dart';
import 'package:one_in_million/widgets/news_feed_card.dart';
import 'package:one_in_million/widgets/responsive.dart';
import 'package:one_in_million/widgets/video_card.dart';
import 'dart:math' as math;

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  TextEditingController searchKeyword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  late FireStoreData _fireStoreData;

  final itemController = ItemScrollController();

  Future<void> scrollNextController() async {
    itemController.jumpTo(index: 2);
  }

  Future<void> scrollPreviousController() async {
    itemController.jumpTo(index: 0);
  }

  @override
  void initState() {
    _fireStoreData = FireStoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Flush flush;
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: AppColor.iconBlue,
        onRefresh: () async {
          if (await getInternetUsingInternetConnectivity()) {
            await _fireStoreData.readInitialData().then((value) {
              setState(() {});
            });
          } else {
            flush = Flush(context);
            flush.message(Constants.noInternet);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Column(
                children: [
                  topLayer(context),
                  _secondLayer(context),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView.builder(
                    itemCount: Globals.newsData.length,
                    itemBuilder: (builder, index) {
                      NewsData newsData = Globals.newsData[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: NewsFeedCard(
                          context,
                          count: '# ${index + 1} ',
                          title: newsData.title!,
                          image: newsData.image!,
                          text: newsData.text!,
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
              flex: 1,
              child: ScrollablePositionedList.builder(
                  itemScrollController: itemController,
                  itemCount: Globals.videoData.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    VideoData data = Globals.videoData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => VideoPlayerScreen(data: data.url!)));
                      },
                      child: VideoCard(
                        context,
                        videoData: data,
                      ),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      scrollPreviousController();

                      setState(() {});
                    },
                    child: Text(
                      "< Previous",
                      style: regularTextStyle(),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      scrollNextController();
                    },
                    child: Text(
                      "Next >",
                      style: regularTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }

  Widget topLayer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColor.iconGreen),
            color: AppColor.iconBlue,
            shape: BoxShape.circle,
          ),
          child: Transform.rotate(
            angle: 180 * math.pi / 180,
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                size: 17,
                color: Colors.white,
              ),
              onPressed: () async {
                _showAlertDialog(context, auth);
              },
            ),
          ),
        ),
        Container(
          child: buildLogo(context),
        ),
      ],
    );
  }

  Widget _secondLayer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today",
              style: regularBoldTextStyle1(),
            ),
            Text(
              DateFormat('MMM.d.yyyy').format(DateTime.now()).toString(),
              style: regularTextStyle(),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "NewsFeed",
              style: regularBoldTextStyle2(),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OurVision()));
          },
          child: Image.asset(
            'assets/logo/ourvision.png',
            width: Responsive.width(100, context) * 30.0,
            height: Responsive.height(100, context) * 10.0,
          ),
        ),
      ],
    );
  }
}

Future<void> _showAlertDialog(BuildContext context, auth) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // <-- SEE HERE
        title: Text(
          'Logout',
          style: TextStyle(color: AppColor.iconBlue),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure want to logout!', style: TextStyle(color: AppColor.iconBlue)),
            ],
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            child: Text('No', style: TextStyle(color: AppColor.iconBlue)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          OutlinedButton(
            child: Text('Yes', style: TextStyle(color: AppColor.iconBlue)),
            onPressed: () async {
              await auth.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
              }
            },
          ),
        ],
      );
    },
  );
}
