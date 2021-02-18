import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_test_app/bloc/recipe_bloc.dart';
import 'package:helios_test_app/widget/recipe_list.dart';


class RecipeStateBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var currentState = BlocProvider.of<RecipeBloc>(context).state;

    if (currentState is InitialState) {
      return Center(
        child: Text("Quelle recette voulez-vous cuisiner aujourd'hui"),
      );
    } else if (currentState is LoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (currentState is LoadedState) {
      if (currentState.recipe.isEmpty) {
        return Center(
          child: Text("Aucune recette trouvée. Essayez une recette différente"),
        );
      }
      return RecipeListBuilder(currentState);
    }else if (currentState is ErrorState) {
      return Center(
        child: Text('Un problème est survenu. Veuillez vérifier la connexion Internet'),
      );
    }
  }
}
