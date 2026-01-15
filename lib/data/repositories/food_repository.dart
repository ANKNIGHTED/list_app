import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:list_app/data/model/food.dart';

class FoodRepository {
  static const String _apiKey = '74c10a3f8ab34570983b6346e5025545';
  Future<List<Food>> fetchFood(String value) async {
    final url =
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=$_apiKey&query=$value';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List results = data["results"];

      return results.map<Food>((e) {
        return Food(
          id: e["id"],
          title: e["title"],
          image: e["image"],
          imageType: e["imageType"],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch food ${response.statusCode}');
    }
  }
}
