import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_in_million/models/faq_data.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/models/news_data.dart';
import 'package:one_in_million/models/user_profile.dart';
import 'package:one_in_million/models/video_data.dart';

class FireStoreData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> readInitialData() async {
    await readVideoData();
    await readNewsData();
    await readFaqData();
    await readUserData();
  }

  Future<void> readVideoData() async {
    List<VideoData> videoData = [];
    try {
      await _firestore.collection('video_data').get().then((value) {
        for (var doc in value.docs) {
          debugPrint('${doc.id} ==> ${doc.data()}');
          VideoData data = VideoData.fromJson(doc.data());
          videoData.add(data);
          debugPrint(data.toJson().toString());
        }
      });
    } catch (e) {
      debugPrint('--->>>Video Data error-->${e.toString()}');
    }
    Globals.videoData = videoData;
  }

  Future<void> readNewsData() async {
    List<NewsData> newsData = [];
    try {
      await _firestore.collection('news_data').get().then((value) {
        for (var doc in value.docs) {
          debugPrint('${doc.id} ==> ${doc.data()}');
          NewsData data = NewsData.fromJson(doc.data());
          newsData.add(data);
          debugPrint(data.toJson().toString());
        }
      });
    } catch (e) {
      debugPrint('--->>>News Data error-->${e.toString()}');
    }
    Globals.newsData = newsData;
  }

  Future<void> readFaqData() async {
    List<FaqData> faqData = [];
    try {
      await _firestore.collection('faq_data').get().then((value) {
        for (var doc in value.docs) {
          debugPrint('${doc.id} ==> ${doc.data()}');
          FaqData data = FaqData.fromJson(doc.data());
          faqData.add(data);
          debugPrint(data.toJson().toString());
        }
      });
    } catch (e) {
      debugPrint('--->>>Faq Data error-->${e.toString()}');
    }
    Globals.faqData = faqData;
  }

  Future<void> readUserData() async {
    try {
      await _firestore.collection('user_profile').get().then((value) {
        for (var doc in value.docs) {
          UserData data = UserData.fromJson(doc.data());
          if (Globals.userCredential == data.uid) {
            Globals.userData = data;
            debugPrint(data.toString());
          }
        }
      });
    } catch (e) {
      debugPrint('--->>>userData Data error-->${e.toString()}');
    }
  }

  Future<void> uploadingData(
    String phoneNumber,
    String uid,
  ) async {
    await _firestore.collection("user_profile").add({
      'PHONE': phoneNumber,
      'UID': uid,
    });
  }
}
