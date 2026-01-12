import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:list_app/data/model/food.dart';

class FoodRepository {
  Future<List<Food>> fetchFood() async {
    const url =
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=74c10a3f8ab34570983b6346e5025545';
    final uri = Uri.parse(url);
    // const String _apiKey = '74c10a3f8ab34570983b6346e5025545';
    final food = await http.get(uri);

    if (food.statusCode == 200) {
      final json = jsonDecode(food.body);
      final List results = json["results"];
      ;
      (jsonDecode(food.body) as Map<String, dynamic>)['results'] as List;
      final result =
          results.map<Food>((e) {
            return Food(id: e["id"], title: e["title"], image: e["image"]);
          }).toList();
      return result;
    } else {
      throw Exception('Failed to fetch food ${food.statusCode}');
    }
  }
}
