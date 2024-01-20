class DonorDonationList {
  int? id;
  String? donationName;
  String? donationDescription;
  int? donationAmount;
  String? status;
  String? createdAt;
  int? donarId;

  DonorDonationList(
      {this.id,
      this.donationName,
      this.donationDescription,
      this.donationAmount,
      this.status,
      this.createdAt,
      this.donarId});

  DonorDonationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    donationName = json['donation_name'];
    donationDescription = json['donation_description'];
    donationAmount = json['donation_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    donarId = json['donar_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['donation_name'] = this.donationName;
    data['donation_description'] = this.donationDescription;
    data['donation_amount'] = this.donationAmount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['donar_id'] = this.donarId;
    return data;
  }
}
