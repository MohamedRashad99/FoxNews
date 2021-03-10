import 'package:http/http.dart' as http;
import 'dart:convert';


import '../utilities/api_utilities.dart';
import '../models/category.dart';

class CategoriesAPI {
  Future<List<Category>> fetchCategories() async {
    List<Category> Categories = List<Category>();
    String categoriesUrl = base_api + all_categories_api;
    var response = await http.get(categoriesUrl);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];
      for (var item in data) {
        Category category =
            Category(item['id'].toString(), item['title'].toString());
        Categories.add(category);
        print(category.title);
      }
    }
    return Categories;
  }
}
