import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/data/entity/foods.dart';

class FoodCardWidget extends StatelessWidget {
  Foods food;
  FoodCardWidget({required this.food});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.purple, width: 0.3),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${food.food_image_name}"),
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress){
                  if (loadingProgress == null) {
                    return child;
                  }else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Align(alignment: Alignment.centerLeft,
                child: Text("₺${food.food_price}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: ColorConstant.purple))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Align(alignment: Alignment.centerLeft,
                child: Text(food.food_name,style: const TextStyle(fontSize:12,fontWeight: FontWeight.w500))),
          ),
        ],
      ),
    );
  }
}
