class BasketFoods {
  String basket_food_id;
  String food_name;
  String food_image_name;
  String food_price;
  String food_order_qty;
  String user_name;

  BasketFoods({
      required this.basket_food_id,
      required this.food_name,
      required this.food_image_name,
      required this.food_price,
      required this.food_order_qty,
      required this.user_name
  });

  factory BasketFoods.fromJson(Map<String, dynamic> json) {
    return BasketFoods(
      basket_food_id: json["sepet_yemek_id"] as String,
      food_name: json["yemek_adi"] as String,
      food_image_name: json["yemek_resim_adi"] as String,
      food_price: json["yemek_fiyat"] as String,
      food_order_qty: json["yemek_siparis_adet"] as String,
      user_name: json["kullanici_adi"] as String,
    );
  }
}
