import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/data/entity/foods.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/main_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/screen/basket_page.dart';
import 'package:flutter_bitirme_projesi/ui/screen/food_detail_page.dart';
import 'package:flutter_bitirme_projesi/ui/screen/home_page.dart';
import 'package:flutter_bitirme_projesi/ui/widget/bottom_nav_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenList = [const HomePage(),const BasketPage()];

    return Scaffold(
      body: BlocBuilder<MainPageCubit,int>(
    builder: (context,screeIndex){
      return screenList[screeIndex];
    }
    ),
        bottomNavigationBar: MyBottomNav(ctx: context,),
    );

  }
}
