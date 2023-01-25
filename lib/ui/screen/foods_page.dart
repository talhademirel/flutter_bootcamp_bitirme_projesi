import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/data/entity/foods.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/food_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/screen/basket_page.dart';
import 'package:flutter_bitirme_projesi/ui/screen/food_detail_page.dart';
import 'package:flutter_bitirme_projesi/ui/widget/bottom_nav_widget.dart';
import 'package:flutter_bitirme_projesi/ui/widget/food_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FoodPage extends StatefulWidget {
  String id;
  FoodPage({required this.id});

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  void initState() {
    super.initState();
    context.read<FoodPageCubit>().getAllFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Yemekler",style: TextStyle(fontSize: 16),),
        backgroundColor: ColorConstant.purple,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_outlined)),
      ),
      body: BlocBuilder<FoodPageCubit, List<Foods>>(
        builder: (context, foodsList) {
          if (foodsList.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0,left: 8.0, right: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  childAspectRatio: 3/4,
                ),
                itemCount: foodsList.length,
                itemBuilder: (context, index) {
                  var food = foodsList[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: food),));
                    },
                    child: FoodCardWidget(food: foodsList[index],),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Lottie.asset("assets/loading.json"),
            );
          }
        },
      ),
      bottomNavigationBar: MyBottomNav(ctx: context,inDetailPage: true),
    );
  }
}
