import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class KColors {
  static const Color blue = Color(0xFF2977F5);
  static const Color primaryText = Color(0xFF456484);
  static const Color bodyText = Color(0xFF858585);
  static const Color border = Color(0x262977F5);
}

const FCM_TOPIC = "all_devices";
const bool development = false;
const String devUrl = '192.168.0.191:3000';
const String prodUrl = 'raw.githubusercontent.com';
const String membersCollectionRef = "Members";
const String firebaseApiKey = "96ce13ad5a9ea15ef8e13c542ca806424d571734";
// const String prodUrl = 'notifs.exun.co';
const String baseUrl = development ? devUrl : prodUrl;
const String getNotifsUrl = '/navgarg/ExunEvents2021/main/notify.json';
const String getTalksUrl = '/navgarg/ExunEvents2021/main/talks.json';
const String getMembersUrl = '/exunclan/website-2022/main/data/members.json';
const String getAlumsUrl = '/navgarg/ExunEvents2021/main/alumni.json';
const String getFacultyUrl = '/navgarg/ExunEvents2021/main/faculty.json';
const String getContactsUrl = '/exunclan/website-2022/main/data/contacts.json';

const String getScheduleUrl = "https://raw.githubusercontent.com/navgarg/exun-app-2021-updated/master/events.json";
// const String getScheduleUrl = "https://raw.githubusercontent.com/navgarg/ExunEvents/main/events.json";


Uri generateUrl(String path) {
  return development ? Uri.http(baseUrl, path) : Uri.https(baseUrl, path);
}
// // Colors
// Color kBlue = Color(0xFF2977F5);
// Color kGrey = Color(0xFF828282);
// Color kBorderColor = Color(0xFFEBF0FF);
// Color kMenuColor = Color(0xFFDADADA);
// Color kSearchBG = Color(0xFFF1F1F1);
// Color kSearchColor = Color(0xFFA3A3A3);
// Color kBlack = Color(0xFF383838);
// Color kLightBlack = Color(0xFF797979);
// Color kLightGrey = Color(0xFFC0C0C0);
//
// // Text Styles
// TextStyle kHeadingStyle =
// GoogleFonts.chivo(fontSize: 42, fontWeight: FontWeight.w400, color: kBlack);
//
// TextStyle kTextStyle =
// GoogleFonts.chivo(fontSize: 22, fontWeight: FontWeight.w400, color: kGrey);
//
// List<dynamic> notifs = [];
// List<dynamic> filteredNotifs = [];
//
// // Constants
// const int kSplashTime = 2;
// const URL = "https://notifs.exun.co/notifications/list/";
// const scheduleAPI = "https://raw.githubusercontent.com/VaishnavGarodia/ExunEvents2020/main/events.json";
// const STATUS_CORRECT = "S10001";
//
// Future<int> getIfVisited() async {
//   SharedPreferences _prefs = await SharedPreferences.getInstance();
//   int state = (_prefs.getInt('state') ?? 0);
//   if (state == 0) {
//     await _prefs.setInt("state", 1);
//   } else if (testing) {
//     var num = Random().nextInt(100);
//     print(num);
//     if (num > 50) {
//       await _prefs.setInt("state", 0);
//     }
//   }
//   return state;
// }
//
// }