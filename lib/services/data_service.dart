import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  static final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  static Future<List<Recipe>?> getRecipes(String filter) async {
    String path = "recipes/";
    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }

    try {
      final response = await _httpService.get(path);

      if ((response?.statusCode == 200 && response?.data != null)) {
        List data = response!.data["recipes"];
        List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();

        print(recipes);
        return recipes;
      }
    } catch (e) {
      print(e);
    }
  }
}
