import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helios_test_app/model/recipe_model.dart';
import 'package:helios_test_app/repository/recipe_repository.dart';
import 'package:meta/meta.dart';
part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  // ajoutez une dépendance pour exécuter votre logique métier
  final RecipeRepository _repository;
  String query;
  int pageNumber = 1;

  RecipeBloc({@required RecipeRepository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  RecipeState get initialState => InitialState();

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is SearchEvent) {
     yield* _mapToSearchEvent(event);
    }else if (event is RefreshEvent) {
     yield*  _getRecipes(query);
    }else if (event is LoadMoreEvent) {
     yield* _getRecipes(query, page: pageNumber);
    }
  }

  Stream<RecipeState> _mapToSearchEvent(SearchEvent event) async* {
    pageNumber = 1;
    query = event.query;
    yield InitialState(); // effacer de la liste précédente
    yield LoadingState(); // affichage de l'indicateur de chargement
    yield* _getRecipes(event.query); // get recipes
  }

  Stream<RecipeState> _getRecipes(String query,  {int page = 1}) async* {
    var currentState = state;
    try{
      List<Result> recipeList = await _repository.getRecipeList(query: query, page: page);
      if (currentState is LoadedState) {
       recipeList =  currentState.recipe + recipeList;
      }
      pageNumber++;
      yield LoadedState(recipe: recipeList, hasReachToEnd: recipeList.isEmpty ? true : false);
    }catch (ex) {
      if (page == 1) yield ErrorState();
      else yield LoadedState(recipe: currentState is LoadedState ? currentState.recipe : [], hasReachToEnd: true);
    }
  }
}
