import 'dart:convert';
import 'package:http/http.dart' as http;

class Categories {
  int id;
  String title;
  String image;

  Categories({required this.id, required this.title, required this.image});

  factory Categories.fromJson(Map<String, dynamic> json) {
    String apiEnpoint = 'http://192.168.1.5:3051';
    return Categories(
      id: json['_id'],
      title: json['title'],
      image: '$apiEnpoint${json['image']}',
    );
  }

  static Future<List<Categories>> fetchData() async {
    final response = await http
        .get(Uri.parse('http://http://192.168.1.5:3051/api/categories'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['success'] == true) {
        final List<dynamic> categoriesJson = jsonData['data'];

        return categoriesJson.map((json) => Categories.fromJson(json)).toList();
      } else {
        throw Exception('API returned an error: ${jsonData['message']}');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
