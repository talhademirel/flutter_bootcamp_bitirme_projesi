import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';

class ProductCardWidget extends StatelessWidget {
  String image_url;
  String product_name;
  String product_price;
  String product_weight;


  ProductCardWidget({required this.image_url,required this.product_name,required this.product_price, required this.product_weight});

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
              image: NetworkImage(image_url),
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Align(alignment: Alignment.centerLeft,
                    child: Text("$product_price",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: ColorConstant.purple))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3,top: 5.0),
                child: Align(alignment: Alignment.centerLeft,
                    child: Text(product_weight,style: const TextStyle(fontSize:11))),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Align(alignment: Alignment.centerLeft,
                child: Text(product_name,style: const TextStyle(fontSize:12,fontWeight: FontWeight.w500))),
          ),
        ],
      ),
    );
  }
}
