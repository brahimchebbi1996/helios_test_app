
import 'package:flutter/foundation.dart';
import 'package:helios_test_app/constant/app_constant.dart';
import 'package:helios_test_app/model/recipe_model.dart';
import 'package:helios_test_app/repository/base_recipe_repository.dart';
import 'package:http/http.dart' as http;

class RecipeRepository extends BaseRecipeRepository {

  final http.Client _httpClient;

  RecipeRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<Result>> getRecipeList({@required String query,@required int page}) async {
    final url = '$baseUrl?q=$query&p=$page';
    print(url);
    final response = await _httpClient.get(url);
    if (response.statusCode == 200) {
      print('success ' + response.statusCode.toString());
      return recipeModelFromJson(response.body).results;
    } else {
      print('got error code ' + response.statusCode.toString());
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
