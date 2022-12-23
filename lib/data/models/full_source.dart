class FullSource {
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  FullSource({this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country});

  factory FullSource.fromJson(Map<String, dynamic> json) {
    return FullSource(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['url'] = url;
    data['category'] = category;
    data['language'] = language;
    data['country'] = country;
    return data;
  }
}