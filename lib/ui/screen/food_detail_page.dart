import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/data/entity/foods.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/food_detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FoodDetailPage extends StatefulWidget {
  Foods food;
  FoodDetailPage({required this.food});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {

  var buyFood = 1;

  void _incFood() {
    setState(() {
      buyFood++;
    });
  }

  void _decFood() {
    setState(() {
      if (buyFood > 1) {
        buyFood--;
      } else {
        buyFood = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Yemek Detayı",style: TextStyle(fontSize: 16),),
        backgroundColor: ColorConstant.purple,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.close)),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.food.food_image_name}"),
            Text("₺${widget.food.food_price}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: ColorConstant.purple)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(widget.food.food_name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: ColorConstant.black)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: ColorConstant.purple,
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.min,
                      children: [
                    TextButton(
                        onPressed: _decFood,
                        style: TextButton.styleFrom(
                            fixedSize: const Size(30, 50),
                            backgroundColor: ColorConstant.white,
                            foregroundColor: ColorConstant.purple),
                        child: const Icon(
                          Icons.remove,
                          size: 25,
                        )),
                    Container(
                      width: 50,
                      color: ColorConstant.purple,
                      child: Text(
                        "$buyFood",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18,color: ColorConstant.white),
                      ),
                    ),
                    TextButton(
                        onPressed: _incFood,
                        style: TextButton.styleFrom(
                          fixedSize: const Size(30, 50),
                            backgroundColor: ColorConstant.white,
                            foregroundColor: ColorConstant.purple),
                        child: const Icon(
                          Icons.add,
                          size: 25,
                        )),
                  ])),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            context.read<FoodDetailCubit>().addFoodToBasket(widget.food,buyFood,"talha_demirel");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.purple,
            padding: EdgeInsets.all(15),
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
            ),
          ),
          child: Text("Sepete ekle"),
        ),
      ),

    );
  }
}

