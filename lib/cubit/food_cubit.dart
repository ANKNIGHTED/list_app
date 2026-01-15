import 'package:bloc/bloc.dart';
import 'package:list_app/data/model/food.dart';
import 'package:list_app/data/repositories/food_repository.dart';
import 'package:meta/meta.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  final FoodRepository _foodRepository;
  FoodCubit(this._foodRepository) : super(FoodInitial());

  Future<void> getFood(String value) async {
    emit(FoodLoading());
    await Future.delayed(Duration.zero);
    try {
      final food = await _foodRepository.fetchFood(value);
      emit(FoodLoaded(food));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  void clearSearch() {
    emit(FoodInitial());
  }
}
