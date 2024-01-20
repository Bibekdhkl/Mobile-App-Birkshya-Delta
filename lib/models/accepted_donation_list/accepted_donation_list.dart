class AllAcceptedDonationList {
  int? id;
  int? treeTransId;
  int? farmerId;
  String? status;
  String? createdAt;
  String? donationName;
  String? donationDescription;
  int? donationAmount;
  int? treeCount;

  AllAcceptedDonationList(
      {this.id,
      this.treeTransId,
      this.farmerId,
      this.status,
      this.createdAt,
      this.donationName,
      this.donationDescription,
      this.donationAmount,
      this.treeCount});

  AllAcceptedDonationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    treeTransId = json['tree_trans_id'];
    farmerId = json['farmer_id'];
    status = json['status'];
    createdAt = json['created_at'];
    donationName = json['donation_name'];
    donationDescription = json['donation_description'];
    donationAmount = json['donation_amount'];
    treeCount = json['tree_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tree_trans_id'] = this.treeTransId;
    data['farmer_id'] = this.farmerId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['donation_name'] = this.donationName;
    data['donation_description'] = this.donationDescription;
    data['donation_amount'] = this.donationAmount;
    data['tree_count'] = this.treeCount;
    return data;
  }
}
