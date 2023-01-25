import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/product_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/screen/food_detail_page.dart';
import 'package:flutter_bitirme_projesi/ui/widget/bottom_nav_widget.dart';
import 'package:flutter_bitirme_projesi/ui/widget/food_card_widget.dart';
import 'package:flutter_bitirme_projesi/ui/widget/product_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProductsPage extends StatefulWidget {
  int id;
  ProductsPage({required this.id});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  
  @override
  void initState() {
    super.initState();
    context.read<ProductPageCubit>().getProducts(widget.id);

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
      body: BlocBuilder<ProductPageCubit, List<QueryDocumentSnapshot>>(
        builder: (context, productsList) {
          if (productsList.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0,left: 8.0, right: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3/4,
                ),
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  var product = productsList[index];
                  return ProductCardWidget(image_url: product["imageUrl"], product_name: product["name"], product_price: product["price"],product_weight: product["weight"],);
                },
              ),
            );
          } else {
            return const Center(
              child: Text("Nothing"),
            );
          }
        },
      ),
      bottomNavigationBar: MyBottomNav(ctx: context,inDetailPage: true),
    );
  }
}

