import 'package:hive_flutter/adapters.dart';
part 'source.g.dart';

@HiveType(typeId: 1)
class Source {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
        id : json['id'],
        name : json['name']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  static void registerAdapter() {
    Hive.registerAdapter(SourceAdapter());
  }
}