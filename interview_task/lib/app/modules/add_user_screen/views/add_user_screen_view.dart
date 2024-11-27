import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:interview_task/constant_widget/button_widget.dart';
import 'package:interview_task/constant_widget/constant.dart';
import 'package:interview_task/constant_widget/text_field_widget.dart';
import 'package:intl/intl.dart';

import '../controllers/add_user_screen_controller.dart';

class AddUserScreenView extends GetView<AddUserScreenController> {
  const AddUserScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddUserScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.1),

            title: Obx(()=> Text(controller.userModel.value.id!=null?'Edit User':'Add User')),
            centerTitle: true,
          ),
          body: Obx(
              ()=> Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey.value,
                    child: Column(
                                  children: [
                    TextFieldWidget(
                      title: "Employee Name",
                      hintText: "Enter Employee Name",
                      controller: controller.nameController.value,
                      onPress: () {},
                    ),
                    TextFieldWidget(
                      title: "Email",
                      hintText: "Enter Email",
                      controller: controller.emailController.value,
                      onPress: () {},
                      validator: (value) => Constant.validateEmail(value),

                      // validator:  Constant.validateEmail(controller.emailController.value.text),
                    ),
                    TextFieldWidget(
                      title: "Phone Number",
                      hintText: "Enter Phone Number",
                      controller: controller.phoneController.value,
                      onPress: () {},
                      keyboardType: TextInputType.number,
                      validator: (value) => Constant.validateMobile(value),
                    ),
                    TextFieldWidget(
                      title: "DOB",
                      hintText: "Select DOB",
                      controller: controller.dobController.value,
                      enabled: false,
                      readOnly: true,
                      onPress: () async {
                        DateTime? datetime = await Constant.selectDate(context, false);
                        controller.dobController.value.text = DateFormat("dd MMMM yyyy").format(datetime!);
                      },
                    ),
                    TextFieldWidget(
                      title: "Address",
                      hintText: "Enter Address",
                      controller: controller.addressController.value,
                      onPress: () {},
                    ),
                                  ],
                                ),
                  )),
            ),
          ),
          bottomNavigationBar: Obx(()=> Padding(
              padding: const EdgeInsets.all(16),
              child: ButtonWidget(
                title: controller.userModel.value.id!=null?'Update':'Save',
                buttonColor: Colors.grey.withOpacity(0.5),
                buttonTextColor: Colors.black,
                onTap: () {
                  if (controller.formKey.value.currentState!
                      .validate()) {
                    controller.userModel.value.id!=null?controller.updateData():controller.insertData();
                  } else {
                    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
                      content: Text("Please Enter Valid Data"),
                    ));
                  }
                },
                size: const Size(double.infinity, 50),
              ),
            ),
          ),
        );
      },
    );
  }
}
