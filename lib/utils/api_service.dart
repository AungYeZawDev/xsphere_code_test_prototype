import 'dart:convert';

import 'package:xsphere_code_test_prototype/model/about_model.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  final String url = 'https://tharlar.site/api/posts';

  Future<AboutModel> getAbout() async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      AboutModel aboutModel = AboutModel.fromJson(response.body);
      return aboutModel;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<http.Response> updateAbout(String title, String description) {
  return http.put(
    Uri.parse('https://tharlar.site/api/posts/8'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title':title,
      'description': description,
    }),
  );
}
}
