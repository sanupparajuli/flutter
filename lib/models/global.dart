import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:one_in_million/models/faq_data.dart';
import 'package:one_in_million/models/news_data.dart';
import 'package:one_in_million/models/user_profile.dart';
import 'package:one_in_million/models/video_data.dart';

class Globals {
  static Box? loginData;
  static dynamic userCredential;
  static BuildContext? context;
  static List<VideoData> videoData = [];
  static List<NewsData> newsData = [];
  static List<FaqData> faqData = [];
  static UserData? userData;
}
