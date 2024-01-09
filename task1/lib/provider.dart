import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

class CategoryProvider {
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('http://jeyam.in/store/api/1.0/1000/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['master_list'];
      List<CategoryModel> categories =
          data.map((json) => CategoryModel.fromJson(json)).toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
