import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/main_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomNav extends StatelessWidget {
  final bool inDetailPage;
  final BuildContext ctx;
  const MyBottomNav({Key? key,this.inDetailPage = false,required this.ctx}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit,int>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined), label: ""),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: state,
          selectedItemColor: ColorConstant.purple,
          iconSize: 30,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          onTap: (index) {
            context.read<MainPageCubit>().updateScreenIndex(index);
            if(inDetailPage){
              Navigator.pop(ctx);
            }
          },
        );
      },
    );
  }
}
