import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/app/model/user_model.dart';
import 'package:interview_task/app/modules/home/controllers/home_controller.dart';
import 'package:interview_task/app/modules/home/views/home_view.dart';
import 'package:interview_task/app/routes/app_pages.dart';
import 'package:interview_task/app/services/database_helper.dart';

class AddUserScreenController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<UserModel> userModel = UserModel().obs;
  DatabaseHelper dataBaseHelper = DatabaseHelper();
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;


  @override
  void onInit() {
    setDefaultData();
    getArgument();
    super.onInit();
  }

  getArgument() {
    dynamic argumentData = Get.arguments;
    if (argumentData != null) {
      userModel.value = argumentData['userModel'];
      nameController.value.text=userModel.value.name!;
      emailController.value.text=userModel.value.email!;
      phoneController.value.text=userModel.value.phoneNumber!;
      dobController.value.text=userModel.value.dob!;
      addressController.value.text=userModel.value.address!;
    }
  }

  setDefaultData() {
    userModel.value.id=null;
    nameController.value.text = "";
    emailController.value.text = "";
    phoneController.value.text = "";
    dobController.value.text = "";
    addressController.value.text = "";
  }

  updateData() async {
    userModel.value.name = nameController.value.text;
    userModel.value.email = emailController.value.text;
    userModel.value.phoneNumber = phoneController.value.text;
    userModel.value.dob = dobController.value.text;
    userModel.value.address = addressController.value.text;

    await dataBaseHelper.updateUser(userModel.value);
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      content: Text("User Updated Successfully...!"),
    ));
    HomeController homeController = Get.put(HomeController());
    homeController.getData();
    homeController.update();
    setDefaultData();
    Get.toNamed(Routes.HOME);

  }

  insertData() async {
    userModel.value.name = nameController.value.text;
    userModel.value.email = emailController.value.text;
    userModel.value.phoneNumber = phoneController.value.text;
    userModel.value.dob = dobController.value.text;
    userModel.value.address = addressController.value.text;

    await dataBaseHelper.insertUser(userModel.value);
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      content: Text("User Added Successfully...!"),
    ));
    HomeController homeController = Get.put(HomeController());
    homeController.getData();
    homeController.update();
    setDefaultData();
    Get.toNamed(Routes.HOME);
  }
}
