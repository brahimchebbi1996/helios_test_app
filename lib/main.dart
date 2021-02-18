import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_test_app/bloc/recipe_bloc.dart';
import 'package:helios_test_app/repository/recipe_repository.dart';
import 'package:helios_test_app/screen/home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        // Creating Bloc provider here and adding first event as AppStarted
          create: (context) =>
          RecipeBloc(repository: RecipeRepository())..add(AppStated()),
          child: HomePage()),
    );
  }
}
