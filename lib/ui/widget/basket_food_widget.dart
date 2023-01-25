import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/data/entity/basket_foods.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/basket_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BasketFoodWidget extends StatelessWidget {
  BasketFoods basketFood;
  int food_order_qty;
  BasketFoodWidget({required this.basketFood,required this.food_order_qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.purple, width: 0.3),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${basketFood.food_image_name}"),
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5.0),
                child: Align(alignment: Alignment.centerLeft,
                    child: Text(basketFood.food_name,style: const TextStyle(fontSize:18,fontWeight: FontWeight.w500))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 10.0),
                child: Align(alignment: Alignment.centerLeft,
                    child: Text("₺${basketFood.food_price}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: ColorConstant.purple))),
              )
            ],
          ),
          const Spacer(),
          Text("x${food_order_qty}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: ColorConstant.purple)),
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${basketFood.food_name} sepetten silinsin mi?"),
                    action: SnackBarAction(
                      label: "Evet",
                      onPressed: () {
                        context.read<BasketPageCubit>().deleteFoodInTheBasket(int.parse(basketFood.basket_food_id), "talha_demirel");
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.delete_outline_rounded,
              ))
        ],
      ),
    );
  }
}
