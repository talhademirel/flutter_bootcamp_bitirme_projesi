import 'package:flutter_bitirme_projesi/data/entity/foods.dart';
import 'package:flutter_bitirme_projesi/data/repo/foods_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodPageCubit extends Cubit<List<Foods>> {
  FoodPageCubit():super(<Foods>[]);

  var foodsRepo = FoodsRepository();

  Future<void> getAllFoods() async {
    var list = await foodsRepo.getAllFoods();
    emit(list);
  }
}