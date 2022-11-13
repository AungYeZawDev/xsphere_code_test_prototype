import 'dart:convert';

class AboutModel {
    AboutModel({
        required this.data,
    });

    final List<AboutData> data;

    factory AboutModel.fromJson(String str) => AboutModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AboutModel.fromMap(Map<String, dynamic> json) => AboutModel(
        data: List<AboutData>.from(json["data"].map((x) => AboutData.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class AboutData {
    AboutData({
        required this.id,
        required this.title,
        required this.description,
    });

    final int id;
    final String title;
    final String description;

    factory AboutData.fromJson(String str) => AboutData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AboutData.fromMap(Map<String, dynamic> json) => AboutData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
    };
}
