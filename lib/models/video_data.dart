class VideoData {
  String? logo;
  String? title;
  String? url;

  VideoData({this.logo, this.title, this.url});

  VideoData.fromJson(Map<String, dynamic> json) {
    logo = json['LOGO'];
    title = json['TITLE'];
    url = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LOGO'] = logo;
    data['TITLE'] = title;
    data['URL'] = url;
    return data;
  }
}
