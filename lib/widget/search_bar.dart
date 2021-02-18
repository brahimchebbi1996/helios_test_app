import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_test_app/bloc/recipe_bloc.dart';

class SearchBar extends StatelessWidget {
  final _recipeQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    var _bloc = context.bloc<RecipeBloc>();
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 40,bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),topLeft: Radius.circular(0),
              topRight: Radius.circular(0)), color: Colors.blue[300]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Ce que tu veux manger aujourd'hui...",hintStyle: TextStyle(color: Colors.white),
                  labelText: 'Trouvez une recette',labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(Icons.fastfood, color: Colors.white,)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Veuillez saisir la recette';
                }
                return null;
              },
              controller: _recipeQuery,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              print('la recette est : '+ _recipeQuery.text.trim());
              _bloc.add(SearchEvent(_recipeQuery.text.trim()));
            },
          )
        ],
      ),
    );
  }
}
