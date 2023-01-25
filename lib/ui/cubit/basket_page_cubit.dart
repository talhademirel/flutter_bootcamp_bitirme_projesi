import 'package:flutter_bitirme_projesi/data/entity/basket_foods.dart';
import 'package:flutter_bitirme_projesi/data/repo/foods_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketPageCubit extends Cubit<List<BasketFoods>> {
  BasketPageCubit():super(<BasketFoods>[]);

  var foodsRepo = FoodsRepository();

  Future<void> getTheFoodsInTheBasket(String user_name) async {
    var list = await foodsRepo.getTheFoodsInTheBasket(user_name);
    emit(list);
  }

  Future<void> deleteFoodInTheBasket(int basket_food_id, String user_name) async {
    await foodsRepo.deleteFoodInTheBasket(basket_food_id, user_name);
    getTheFoodsInTheBasket(user_name);
  }


}