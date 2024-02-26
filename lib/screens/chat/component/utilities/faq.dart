import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/services/firestore_data.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/internet_connectivity.dart';
import 'package:one_in_million/utils/message_notifier.dart';

class FaqChat extends StatefulWidget {
  const FaqChat({super.key});

  @override
  State<FaqChat> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FaqChat> {
  late FireStoreData _fireStoreData;
  @override
  void initState() {
    _fireStoreData = FireStoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Flush flush;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          'Frequently Asked Questions',
          style: TextStyle(color: AppColor.iconBlue),
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColor.iconBlue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(
            Icons.menu,
            color: Colors.white,
          )
        ],
      ),
      body: RefreshIndicator(
        color: AppColor.iconBlue,
        onRefresh: () async {
          if (await getInternetUsingInternetConnectivity()) {
            await _fireStoreData.readFaqData().then((value) {
              setState(() {});
            });
          } else {
            flush = Flush(context);
            flush.message(Constants.noInternet);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(children: <Widget>[
            Container(
              color: Colors.white,
              height: 20,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Globals.faqData.length,
                itemBuilder: (context, index) {
                  return FAQ(
                    question: Globals.faqData[index].question!,
                    answer: Globals.faqData[index].answer!,
                    ansStyle: TextStyle(color: AppColor.iconBlue, fontSize: 12),
                    queStyle: TextStyle(color: AppColor.iconGreen, fontSize: 12),
                  );
                })
          ]),
        ),
      ),
    ));
  }
}
