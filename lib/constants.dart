import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color appBackground = Color(0xffD7D7D7);
Color buttonColor = Color(0xff00008B);
const Color buttonLightColor = Color(0xff0909dc);

const Color textGreyColor = Color(0xff707B81);
const Color textGrey = Color(0xffd7d6d6);
const Color linkColor = Color(0xff0D47A1);
const Color textColor = Color(0xFF1A2530);
const Color buttonGrey = Color(0xffF5F5F7);
const String email = 'jobnowkemal@gmail.com';

const String serviceIds = 'service_jhgv7fm';
const String templateIds = 'template_odzf34m';
const String userIds = 'PWRwPEJ_w3iV_E93M';

void showToast(String message, Color color) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: color,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM);
}
