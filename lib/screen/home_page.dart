import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_test_app/bloc/recipe_bloc.dart';
import 'package:helios_test_app/widget/recipe_state_builder.dart';
import 'package:helios_test_app/widget/search_bar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    var _bloc = context.bloc<RecipeBloc>();
    _bloc.add(SearchEvent(""));

  }

  @override
  Widget build(BuildContext context) {
    var _bloc = context.bloc<RecipeBloc>();
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
        // Map your state and return the widget
        return Column(
          children: <Widget>[
            SearchBar(),
            Expanded(
              child: RecipeStateBuilder(),
            ),
          ],
        );
      }),
    );
  }


}
