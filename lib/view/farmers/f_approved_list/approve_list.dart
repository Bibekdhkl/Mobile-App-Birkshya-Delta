import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/data/response/status.dart';
import 'package:project_app/view_model/controller/farmer/f_approved_list.dart';

class ApprovedList extends StatefulWidget {
  const ApprovedList({Key? key}) : super(key: key);

  @override
  _ApprovedListState createState() => _ApprovedListState();
}

class _ApprovedListState extends State<ApprovedList> {
  final AllApprovedDonationController controller =
      Get.put(AllApprovedDonationController());

  @override
  void initState() {
    super.initState();
    controller.approvedDonationListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Approved List'),
      ),
      body: Obx(() {
        if (controller.rxRequestStatus.value == Status.LOADING) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.rxRequestStatus.value == Status.ERROR) {
          return Center(child: Text('Error: ${controller.error.value}'));
        } else {
          return ListView.builder(
            itemCount: controller.approvedDonationList.length,
            itemBuilder: (context, index) {
              var donation = controller.approvedDonationList[index];
              return ListTile(
                title: Text(donation.donationName ?? ""),
                subtitle: Text(
                    'Amount: ${donation.donationAmount ?? 0}\nDescription: ${donation.donationDescription ?? ""}'),
              );
            },
          );
        }
      }),
    );
  }
}
