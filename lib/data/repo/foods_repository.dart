import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bitirme_projesi/data/entity/basket_foods.dart';
import 'package:flutter_bitirme_projesi/data/entity/basket_foods_response.dart';
import 'package:flutter_bitirme_projesi/data/entity/foods.dart';
import 'package:flutter_bitirme_projesi/data/entity/foods_response.dart';

class FoodsRepository {
  List<Foods> parseFoodsResponse(String response) {
    return FoodsResponse.fromJson(json.decode(response)).foods;
  }

  List<BasketFoods> parseBasketFoodsResponse(String response) {
    return BasketFoodsResponse.fromJson(json.decode(response)).basketFoods;
  }

  Future<List<Foods>> getAllFoods() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    return parseFoodsResponse(response.data.toString());
  }

  Future<void> addFoodToBasket(Foods foods, int food_order_qty, String user_name) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {
      "yemek_adi": foods.food_name,
      "yemek_resim_adi": foods.food_image_name,
      "yemek_fiyat": int.parse(foods.food_price),
      "yemek_siparis_adet": food_order_qty,
      "kullanici_adi": user_name
    };
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print(response.data);
  }

  Future<List<BasketFoods>> getTheFoodsInTheBasket(String user_name) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var response = await Dio().post(url, data: FormData.fromMap({"kullanici_adi": user_name}));
    print(response.data);
    if (response.data.contains("success")) {
      BasketFoodsResponse basketFoodsResponse =
      BasketFoodsResponse.fromJson(json.decode(response.data));
      return basketFoodsResponse.basketFoods;
    } else {
      return [];
    }
  }

  Future<void> deleteFoodInTheBasket(int basket_food_id, String user_name) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {
      "sepet_yemek_id": basket_food_id,
      "kullanici_adi": user_name
    };
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print(response.data);
  }

  Future<List<QueryDocumentSnapshot>> getCategorys() async {
    var firestore = FirebaseFirestore.instance;
    var categorys = firestore.collection('Category');
    var response = await categorys.get();
    return response.docs;
  }

  Future<List<QueryDocumentSnapshot>> getProducts(int id) async {
    var firestore = FirebaseFirestore.instance;
    var categorys = firestore.collection('Category/$id/Products');
    var response = await categorys.get();
    print(response.docs);
    return response.docs;

  }

}
