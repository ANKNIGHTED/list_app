part of 'recipe_cubit.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}

final class RecipeLoading extends RecipeState {}

final class RecipeLoaded extends RecipeState {
  final Recipe recipe;
  RecipeLoaded(this.recipe);
}

final class RecipeError extends RecipeState {
  final String message;
  RecipeError(this.message);
}
