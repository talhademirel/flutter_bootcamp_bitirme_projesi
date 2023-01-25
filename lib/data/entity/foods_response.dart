import 'package:flutter_bitirme_projesi/data/entity/foods.dart';

class FoodsResponse {
  List<Foods> foods;
  int success;

  FoodsResponse({required this.foods,required this.success});

  factory FoodsResponse.fromJson(Map<String,dynamic> json){
    var jsonArray = json["yemekler"] as List;
    var foods = jsonArray.map((jsonArrayList) => Foods.fromJson(jsonArrayList)).toList();
    return FoodsResponse(
        foods: foods,
        success: json["success"] as int
    );
  }
}