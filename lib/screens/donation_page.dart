import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/circular_button.dart';
import 'package:one_in_million/widgets/textField.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final Map<String, bool> _tempData = {
    "\$55": false,
    "\$100": false,
    "\$200": false,
    "\$500": false,
    "\$1000": false,
  };

  final bool isChecked = false;

  bool _checkMark = false;
  TextEditingController searchKeyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            _topLayer(context),
            const SizedBox(
              height: 10,
            ),
            _secondLayer(context),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Donate and ",
                  style: regularTextStyle1(),
                ),
                Text(
                  "Be The Difference",
                  style: regularBoldTextStyle1(),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _tempData.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      String data = _tempData.keys.elementAt(index);
                      bool value = _tempData.values.elementAt(index);
                      _tempData[data] = !value;
                    });
                  },
                  child: CircularButton(
                    bgColor: _tempData.values.elementAt(index)
                        ? AppColor.defaultBlue
                        : AppColor.defaultWhite,
                    buttonScale: 2,
                    child: Text(
                      _tempData.keys.elementAt(index),
                      style: regularBoldTextStyle(
                        color: _tempData.values.elementAt(index)
                            ? AppColor.defaultWhite
                            : AppColor.defaultBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _donationLayer(context),
            const SizedBox(
              height: 50,
            ),
            Text(
              Constants.donationMsg,
              textAlign: TextAlign.center,
              style: regularBoldTextStyle(color: AppColor.deepBlue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topLayer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            CircularButton(
              bgColor: AppColor.defaultRed,
              child: Icon(
                Icons.done_all,
                color: AppColor.defaultWhite,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            CircularButton(
              bgColor: AppColor.deepBlue,
              child: Icon(
                Icons.notifications,
                color: AppColor.defaultWhite,
              ),
            ),
          ],
        ),
        Container(
          height: 100,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          color: Colors.blue,
        )
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
            Text(
              "Donation",
              style: regularBoldTextStyle1(),
            ),
          ],
        ),
        Flexible(
          child: AppTextField(
            controller: searchKeyword,
            hintText: Constants.search,
            textFieldIcon: const Icon(
              Icons.search,
            ),
          ),
        ),
      ],
    );
  }

  Widget _donationLayer(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
                value: _checkMark,
                onChanged: (value) => setState(() {
                      _checkMark = !_checkMark;
                    })),
            Text(
              "I'd like to confirm my donation",
              style: regularTextStyle(color: Colors.green),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.defaultRed,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              "Donate",
              style: regularTextStyle(
                color: AppColor.defaultRed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
