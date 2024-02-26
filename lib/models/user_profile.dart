class UserData {
  String? phoneNumber;
  String? gender;
  String? uid;
  UserData({this.phoneNumber, this.gender, this.uid});

  UserData.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['PHONE'];
    gender = json['GENDER'];
    uid = json['UID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PHONE'] = phoneNumber;
    data['GENDER'] = gender;
    data['UID'] = uid;
    return data;
  }
}
