import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/data/entity/basket_foods.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/basket_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/widget/basket_food_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {

  @override
  void initState() {
    super.initState();
    context.read<BasketPageCubit>().getTheFoodsInTheBasket("talha_demirel");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.purple,
        centerTitle: true,
        title: Text("Sepetim"),
      ),
      body: BlocBuilder<BasketPageCubit,List<BasketFoods>>(
        builder: (context, basketFoodsList) {
          if(basketFoodsList.isNotEmpty){
            return ListView.builder(
              itemCount: basketFoodsList.length,
              itemBuilder: (context, index) {
                var basketFood = basketFoodsList[index];
                return BasketFoodWidget(basketFood: basketFood,food_order_qty: int.parse(basketFood.food_order_qty));
              },);

          }else{
            return const Center(
              child: Text("Ürün yok"),
            );
          }
        },
      ),
    );
  }
}

