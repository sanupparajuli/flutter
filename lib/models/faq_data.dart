class FaqData {
  String? question;
  String? answer;

  FaqData({
    this.question,
    this.answer,
  });

  FaqData.fromJson(Map<String, dynamic> json) {
    question = json['QUESTION'];
    answer = json['ANSWER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['QUESTION'] = question;
    data['ANSWER'] = answer;
    return data;
  }
}
