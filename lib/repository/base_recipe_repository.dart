import 'package:helios_test_app/model/recipe_model.dart';

abstract class BaseRecipeRepository {
  Future<List<Result>> getRecipeList({String query, int page});
  void dispose();
}