import 'package:bloc/bloc.dart';
import 'package:list_app/data/model/recipe.dart';
import 'package:list_app/data/repositories/recipe_repository.dart';
import 'package:meta/meta.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository _recipeRepository;
  RecipeCubit(this._recipeRepository) : super(RecipeInitial());

  Future<void> fetchDetails(int id) async {
    emit(RecipeLoading());
    try {
      final data = await _recipeRepository.fetchRecipeDetails(id);
      final recipe = Recipe.fromJson(data);
      emit(RecipeLoaded(recipe));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }
}
