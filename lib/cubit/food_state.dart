part of 'food_cubit.dart';

@immutable
sealed class FoodState {
  FoodState();
}

final class FoodInitial extends FoodState {
  FoodInitial();
}

final class FoodLoading extends FoodState {
  FoodLoading();
}

final class FoodLoaded extends FoodState {
  final List<Food> food;
  FoodLoaded(this.food);
}

class FoodError extends FoodState {
  final String message;
  FoodError(this.message);
}
