import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constant {

  static   String? validateEmail(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }


  static String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static Future<DateTime?> selectDate(context, bool isForFuture) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate:isForFuture?DateTime.now(): DateTime.now().subtract(const Duration(days: 365 * 18)),
        firstDate:  DateTime(1945),
        lastDate: isForFuture?DateTime.now():DateTime.now().subtract(const Duration(days: 365 * 18)));
    return pickedDate;
  }

  static DateTime? stringToDateTime(String dateString) {
    try {
      DateFormat format = DateFormat('dd MMMM yyyy');
      return format.parse(dateString);
    } catch (e) {
      log("Error parsing date: $e");
      return null;
    }
  }

}
