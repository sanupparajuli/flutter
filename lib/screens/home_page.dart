import 'package:flutter/material.dart';
import 'package:one_in_million/screens/chat/chat_page.dart';
import 'package:one_in_million/screens/newsFeed_page.dart';
import 'package:one_in_million/screens/profile_screen.dart';
import 'package:one_in_million/screens/webviews.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final List<Color> colors = [
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentPage) {
        setState(() {
          currentPage = value;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: BottomBar(
            currentPage: currentPage,
            tabController: tabController,
            colors: colors,
            unselectedColor: Colors.white,
            barColor: AppColor.iconBlue,
            end: 2,
            start: 10,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                NewsFeedPage(),
                WebViewPage(),
                ChatScreen(),
                ProfilePages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Delete extends StatelessWidget {
  const Delete({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 100,
        color: Colors.blue,
        child: Text(
          "Empty Page",
          style: regularBoldTextStyle1(color: Colors.white),
        ),
      ),
    );
  }
}
