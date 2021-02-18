part of 'recipe_bloc.dart';

@immutable
abstract class RecipeEvent extends Equatable {
// L'événement est une interaction de l'utilisateur avec votre écran
  @override
  List<Object> get props => [];
}

class AppStated extends RefreshEvent {}

class SearchEvent extends RecipeEvent {
  final String query;

  SearchEvent(this.query);
  @override
  List<Object> get props => [query];
}

class RefreshEvent extends RecipeEvent {}

class LoadMoreEvent extends RecipeEvent {}


