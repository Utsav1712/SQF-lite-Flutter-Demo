import 'dart:developer';

import 'package:get/get.dart';
import 'package:interview_task/app/model/user_model.dart';
import 'package:interview_task/app/services/database_helper.dart';
import 'package:interview_task/constant_widget/constant.dart';

class HomeController extends GetxController {
  RxList<UserModel> userList = <UserModel>[].obs;
  DatabaseHelper dataBaseHelper = DatabaseHelper();
  RxBool isLoading= true.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value=true;
    await dataBaseHelper.getAllUsers().then((value) => userList.value=value,);
    isLoading.value=false;
  }

  Future<void> filterUsers({String? name, String? phone, DateTime? startDate, DateTime? endDate}) async {
    userList.value = await dataBaseHelper.getAllUsers();
    var filteredList = userList.where((user) {
      final matchesName = name == null || user.name!.contains(name);
      final matchesPhone = phone == null || user.phoneNumber!.contains(phone);
      final matchesDate = startDate == null || endDate == null || (Constant.stringToDateTime( user.dob!)!.isAfter(startDate) && Constant.stringToDateTime( user.dob!)!.isBefore(endDate) || (Constant.stringToDateTime(user.dob!)! == startDate || Constant.stringToDateTime( user.dob!)! == endDate ));
      return matchesName && matchesPhone && matchesDate;
    }).toList();
    userList.value = filteredList;
  }

}
