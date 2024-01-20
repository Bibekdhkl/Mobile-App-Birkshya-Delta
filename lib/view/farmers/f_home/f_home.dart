import 'package:flutter/material.dart';
import 'package:project_app/data/response/status.dart';
import 'package:project_app/resources/routes/routes_name.dart';
import 'package:project_app/view/farmers/f_home/widget/f_list.dart';
import 'package:project_app/view_model/controller/farmer/available_donation_vm.dart';
import 'package:project_app/view_model/controller/user_preferences/user_preferences_view_model.dart';
import 'package:get/get.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  UserPreference userPreference = UserPreference();
  final AllAvailableDonationController controller =
      Get.put(AllAvailableDonationController());

  @override
  void initState() {
    super.initState();
    controller.availableDonationListApi();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("farmer_home".tr),
            actions: [
              IconButton(
                  onPressed: () {
                    userPreference.removeUser().then(
                      (value) {
                        Get.toNamed(RouteName.loginScreen);
                      },
                    );
                  },
                  icon: Icon(Icons.logout)),
              IconButton(
                onPressed: () {
                  Locale currentLocale = Get.locale!;
                  if (currentLocale.languageCode == 'en') {
                    Get.updateLocale(Locale('ne', 'NP'));
                  } else {
                    Get.updateLocale(Locale('en', 'US'));
                  }
                },
                icon: Icon(Icons.language),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black,
                                  const Color.fromARGB(255, 229, 160, 160)
                                ],
                              ),
                            ),
                            child: Text("total_donation".tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black,
                                  const Color.fromARGB(255, 250, 126, 126)
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("total_count".tr,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Text("50",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black,
                                  Color.fromARGB(255, 249, 88, 88)
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("wallet_balance".tr,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Text("Rs. 15",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text("View All Offers",
                          style: TextStyle(color: Colors.black, fontSize: 23)),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("View All")),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Obx(() {
                    if (controller.rxRequestStatus.value == Status.LOADING) {
                      return CircularProgressIndicator();
                    } else if (controller.rxRequestStatus.value ==
                        Status.ERROR) {
                      return Text('Error: ${controller.error.value}');
                    } else {
                      return controller.availableDonationList.isEmpty
                          ? Center(child: Text('No offers available right now'))
                          : Column(
                              children: controller.availableDonationList
                                  .map((donation) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OfferList(
                                      id: donation.id ?? 0,
                                      title: donation.donationName ??
                                          "", // replace with actual field names
                                      description:
                                          donation.donationDescription ?? "",
                                      amount: donation.donationAmount
                                          .toString() // replace with actual field names
                                      ),
                                );
                              }).toList(),
                            );
                    }
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
