class NewsData {
  String? title;
  String? text;
  String? image;

  NewsData({
    this.title,
    this.text,
    this.image,
  });

  NewsData.fromJson(Map<String, dynamic> json) {
    title = json['TITLE'];
    text = json['TEXT'];
    image = json['IMAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TITLE'] = title;
    data['TEXT'] = text;
    data['IMAGE'] = image;
    return data;
  }
}
