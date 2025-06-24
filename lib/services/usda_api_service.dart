import 'dart:convert';
import 'package:http/http.dart' as http;

class USDAApiService {
  static const String _baseUrl = 'https://api.nal.usda.gov/fdc/v1';
  static const String _apiKey = 'CLWjBNOepcHOqu5uwC01EjofG8tox7imA0ydSMDr';

  /// Search for foods by query string
  static Future<Map<String, dynamic>> searchFoods(String query, {int pageSize = 25}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/foods/search?api_key=$_apiKey&query=$query&pageSize=$pageSize'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search foods: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching foods: $e');
    }
  }

  /// Get detailed food information by FDC ID
  static Future<Map<String, dynamic>> getFoodDetails(int fdcId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/food/$fdcId?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get food details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting food details: $e');
    }
  }

  /// Get nutrition information for a specific food
  static Future<List<Map<String, dynamic>>> getFoodNutrients(int fdcId) async {
    try {
      final foodData = await getFoodDetails(fdcId);
      final nutrients = foodData['foodNutrients'] as List?;
      
      if (nutrients != null) {
        return nutrients.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      throw Exception('Error getting food nutrients: $e');
    }
  }

  /// Search for foods and return simplified results
  static Future<List<Map<String, dynamic>>> searchFoodsSimple(String query) async {
    try {
      final searchResults = await searchFoods(query);
      final foods = searchResults['foods'] as List?;
      
      if (foods != null) {
        return foods.map((food) {
          return {
            'fdcId': food['fdcId'],
            'description': food['description'],
            'brandName': food['brandName'],
            'brandOwner': food['brandOwner'],
            'ingredients': food['ingredients'],
          };
        }).cast<Map<String, dynamic>>().toList();
      }
      return [];
    } catch (e) {
      throw Exception('Error searching foods: $e');
    }
  }
} 