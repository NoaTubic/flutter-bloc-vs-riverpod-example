class Fact {
  String id;
  String text;

  Fact({
    required this.id,
    required this.text,
  });

  factory Fact.fromJson(Map<String, dynamic> json) => Fact(
        id: json['id'] as String,
        text: json['text'] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;

    return data;
  }
}
