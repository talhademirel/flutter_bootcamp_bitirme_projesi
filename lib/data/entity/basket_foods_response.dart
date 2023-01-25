import 'package:flutter_bitirme_projesi/data/entity/basket_foods.dart';

class BasketFoodsResponse {
  List<BasketFoods> basketFoods;
  int success;

  BasketFoodsResponse({required this.basketFoods,required this.success});

  factory BasketFoodsResponse.fromJson(Map<String,dynamic> json){
    var jsonArray = json["sepet_yemekler"] as List;
    var basketFoods = jsonArray.map((jsonArrayList) => BasketFoods.fromJson(jsonArrayList)).toList();
    return BasketFoodsResponse(
        basketFoods: basketFoods,
        success: json["success"] as int
    );
  }
}