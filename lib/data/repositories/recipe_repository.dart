import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeRepository {
  static const String _apiKey = '74c10a3f8ab34570983b6346e5025545';

  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/information?apiKey=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch recipe details');
    }
  }
}
