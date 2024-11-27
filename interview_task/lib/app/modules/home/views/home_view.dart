import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:interview_task/app/model/user_model.dart';
import 'package:interview_task/app/routes/app_pages.dart';
import 'package:interview_task/constant_widget/button_widget.dart';
import 'package:interview_task/constant_widget/constant.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Employee'),
              centerTitle: true,
              backgroundColor: Colors.grey.withOpacity(0.1),
              actions: [
                IconButton(
                    onPressed: () {
                      showFilterDialog(context, controller);
                    },
                    icon: const Icon(Icons.filter_alt_outlined))
              ],
            ),
            body: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.userList.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/animation/no-data.gif',
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("No Data Available"),
                        ],
                      ))
                    : ListView.builder(
                        itemCount: controller.userList.length,
                        itemBuilder: (context, index) {
                          UserModel userModel = controller.userList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.ADD_USER_SCREEN, arguments: {"userModel": userModel});
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12), color: Colors.grey.withOpacity(0.2)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Name : ${userModel.name}"),
                                      Text("Email : ${userModel.email}"),
                                      Text("Phone : ${userModel.phoneNumber}"),
                                      Text("DOB : ${userModel.dob}"),
                                      Text("Address : ${userModel.address}"),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: IconButton(
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  elevation: 0,
                                                  backgroundColor: Colors.transparent,
                                                  insetPadding: const EdgeInsets.all(20),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                        color: Colors.grey.withOpacity(0.5),
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        const Text(
                                                          "Alert...!",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Are you sure you want to delete this record?",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.black.withOpacity(0.8),
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ButtonWidget(
                                                                title: "Cancel",
                                                                buttonColor: Colors.grey,
                                                                buttonTextColor: Colors.black,
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                size: const Size(double.infinity, 50),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: ButtonWidget(
                                                                title: "Delete",
                                                                buttonColor: Colors.blueGrey,
                                                                buttonTextColor: Colors.black,
                                                                onTap: () async {
                                                                  await controller.dataBaseHelper
                                                                      .deleteUser(userModel.id.toString());
                                                                  controller.getData();
                                                                  controller.update();
                                                                },
                                                                size: const Size(double.infinity, 50),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.delete_rounded)),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Get.toNamed(Routes.ADD_USER_SCREEN);
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void showFilterDialog(BuildContext context, HomeController controller) {
    // Controllers for name and phone input
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    // Reactive variables for startDate and endDate
    Rx<DateTime?> startDate = Rx<DateTime?>(null);
    Rx<DateTime?> endDate = Rx<DateTime?>(null);

    showDialog(
      context: context,
      builder: (context) {
        return Obx(
          () => AlertDialog(
            title: const Text('Filter'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name input field
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  // Phone number input field
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  // Start date picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          DateTime? picked = await Constant.selectDate(context, false);
                          if (picked != null) startDate.value = picked;
                        },
                        child: const Text('Start Date'),
                      ),
                      Text(startDate.value != null
                          ? '${startDate.value!.day}/${startDate.value!.month}/${startDate.value!.year}'
                          : 'No date selected'),
                    ],
                  ),
                  // End date picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          DateTime? picked = await Constant.selectDate(context, false);
                          if (picked != null) endDate.value = picked;
                        },
                        child: const Text('End Date'),
                      ),
                      Text(endDate.value != null
                          ? '${endDate.value!.day}/${endDate.value!.month}/${endDate.value!.year}'
                          : 'No date selected'),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              // Cancel button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              // Apply filter button
              TextButton(
                onPressed: () {
                  controller.filterUsers(
                    name: nameController.text,
                    phone: phoneController.text,
                    startDate: startDate.value,
                    endDate: endDate.value,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }
}
