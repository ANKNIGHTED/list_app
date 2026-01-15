part of 'food_cubit.dart';

@immutable
sealed class FoodState {
  const FoodState();
}

// Initial state when the app starts
final class FoodInitial extends FoodState {
  FoodInitial();
}

// General loading state (used for search and details)
final class FoodLoading extends FoodState {
  FoodLoading();
}

// State when the search results are returned
final class FoodLoaded extends FoodState {
  final List<Food> food;
  FoodLoaded(this.food);
}

// NEW: State when the specific recipe details are fetched
final class FoodDetailLoaded extends FoodState {
  // Using Map<String, dynamic> since Spoonacular returns a complex JSON object
  // for the /information endpoint.
  final Map<String, dynamic> detailedFood;

  FoodDetailLoaded(this.detailedFood);
}

// State for when things go wrong
class FoodError extends FoodState {
  final String message;
  FoodError(this.message);
}
