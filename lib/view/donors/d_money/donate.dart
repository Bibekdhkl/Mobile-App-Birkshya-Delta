import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';
import 'package:get/get.dart';
import 'package:project_app/resources/components/round_button.dart';
import 'package:project_app/resources/routes/routes.dart';
import 'package:project_app/resources/routes/routes_name.dart';
import 'package:project_app/view_model/controller/donor/make_donation_vm.dart';

class DonateMoneyPage extends StatefulWidget {
  @override
  State<DonateMoneyPage> createState() => _DonateMoneyPageState();
}

class _DonateMoneyPageState extends State<DonateMoneyPage> {
  final donateVM = Get.put(DonationVM());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Money'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: donateVM.donation_name.value,
              decoration: InputDecoration(hintText: "Donation Name"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: donateVM.donation_description.value,
              decoration: InputDecoration(hintText: "Donation Description"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: donateVM.tree_count.value,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Donation Amount"),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 16.0),
            Obx(() {
              return ElevatedButton(
                child: Text("Pay Amount".tr),
                onPressed: donateVM.loading.value
                    ? null
                    : () async {
                        int totalTrees =
                            int.tryParse(donateVM.tree_count.value.text) ?? 0;
                        int liveValue = totalTrees * 100;
                        bool? shouldProceed = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text(
                                  'The amount is Rs. $liveValue. Are you sure you want to pay?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        if (shouldProceed == true) {
                          donateVM.donateApi();
                          donateVM.donation_description.value.clear();
                          donateVM.donation_name.value.clear();
                          donateVM.tree_count.value.clear();
                        }
                      },
              );
            })
          ],
        ),
      ),
    );
  }

  // Function to handle Khalti payment
  void _handlePayment(BuildContext context) {}
}
