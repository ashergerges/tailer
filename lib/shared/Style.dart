// // import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
Color ko = const Color(0xff1a033b);
Color petroleum = const Color(0xFF324755);
Color white = Colors.white;
Color black = Colors.black;
Color orange = const Color(0xFFD97D54);
Color beige = const Color(0xFFB9B0A2);
Color lightGrey = Colors.grey.shade300;
Color darkGrey = Colors.grey.shade600;
Color teal = const Color(0xFF87bcbf);
const String serverToken =
    'AAAApauI2XA:APA91bH3RBNGc4jsgpy6dvQ4DX0QYFxORbrEFVxrzl88NnyTQOu8U39cAeVXEVYuWvZtIcjf6k2J03QDci8H25v3o5XQfgSTVJPuB8thglkFENXdpO8EdwDMjBvkhLdLwMdjeJOJT5rp';
//final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

double sizeFromHeight(BuildContext context, double fraction,
    {bool hasAppBar = false}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final calculateHeight = (hasAppBar
          ? (screenHeight -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top)
          : screenHeight) /
      fraction;
  return calculateHeight;
}

double sizeFromWidth(BuildContext context, double fraction) {
  final calculateWidth = MediaQuery.of(context).size.width / fraction;
  return calculateWidth;
}
//
// sendAndRetrieveMessage(String title, String body, String token) async {
//   await firebaseMessaging.requestPermission(
//       sound: true, badge: true, alert: true, provisional: false);
//   await http.post(
//     Uri.parse('https://fcm.googleapis.com/fcm/send'),
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'key=$serverToken',
//     },
//     body: jsonEncode(
//       <String, dynamic>{
//         'notification': <String, dynamic>{
//           'body': body,
//           'title': title,
//           'sound': "assets/sound/notification.mp3",
//           'default_sound': true,
//           'default_vibrate_timings': true,
//           'default_light_settings': true,
//         },
//         'priority': 'high',
//         'data': <String, dynamic>{
//           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//         },
//         'to': token,
//       },
//     ),
//   );
// }
