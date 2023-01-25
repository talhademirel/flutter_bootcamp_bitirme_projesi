import 'package:flutter_bitirme_projesi/data/entity/foods.dart';
import 'package:flutter_bitirme_projesi/data/repo/foods_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetailCubit extends Cubit<void>{
  FoodDetailCubit():super(0);

  var foodsRepo = FoodsRepository();

  Future<void> addFoodToBasket(Foods foods, int food_order_qty, String user_name) async {
    var basketFoods = await foodsRepo.getTheFoodsInTheBasket(user_name);

    for (var b in basketFoods) {
      if (b.food_name == foods.food_name) {
        food_order_qty +=  int.parse(b.food_order_qty);
        await foodsRepo.deleteFoodInTheBasket(int.parse(b.basket_food_id),"talha_demirel");
        break;
      }
    }
    await foodsRepo.addFoodToBasket(foods,food_order_qty,user_name);
  }
}