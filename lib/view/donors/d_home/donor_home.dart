import 'package:flutter/material.dart';
import 'package:project_app/data/response/status.dart';
import 'package:project_app/resources/colors/app_color.dart';
import 'package:project_app/resources/components/round_button.dart';
import 'package:project_app/resources/routes/routes_name.dart';
import 'package:project_app/view/donors/d_home/widget/expanded_card.dart';
import 'package:project_app/view/donors/d_home/widget/d_list.dart';
import 'package:project_app/view/donors/d_money/donate.dart';
import 'package:project_app/view_model/controller/donor/donation_list_vm.dart';
import 'package:project_app/view_model/controller/screen_controller/screen_controller.dart';
import 'package:project_app/view_model/controller/user_preferences/user_preferences_view_model.dart';
import 'package:get/get.dart';

class DonorHome extends StatefulWidget {
  const DonorHome({super.key});

  @override
  State<DonorHome> createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  UserPreference userPreference = UserPreference();
  final DonorDonationListController donationListController =
      Get.put(DonorDonationListController()); // initialize your controller
  final NavController navController = Get.put(NavController());

  @override
  void initState() {
    super.initState();
    donationListController.donationListApi();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("plan_a_tree".tr),
            actions: [
              IconButton(
                  onPressed: () {
                    userPreference.removeUser().then(
                      (value) {
                        navController.logoutUser();

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
                            child: Text("total_plan_tree",
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
                                  const Color.fromARGB(255, 23, 241, 135),
                                  Colors.green,
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("total_donations".tr,
                                    style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20)),
                                Text("50",
                                    style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20)),
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
                                Text("total_donated_amount",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Text("Rs. 100",
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
                      child: Text("Recent Donation",
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonateMoneyPage()),
                              );
                            },
                            child: Text('+ Donate Money')),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (donationListController.rxRequestStatus.value ==
                      Status.LOADING) {
                    return CircularProgressIndicator();
                  } else if (donationListController.rxRequestStatus.value ==
                      Status.ERROR) {
                    return Text('Error: ${donationListController.error.value}');
                  } else {
                    return donationListController.donationList.isEmpty
                        ? Center(child: Text('List is empty'))
                        : Column(
                            children: donationListController.donationList
                                .map((donation) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: d_list(
                                  title: donation.donationName ??
                                      "", // replace with actual field names
                                  description: donation.donationDescription ??
                                      "", // replace with actual field names
                                ),
                              );
                            }).toList(),
                          );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
