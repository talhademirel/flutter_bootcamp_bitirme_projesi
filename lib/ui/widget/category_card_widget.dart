import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  String image_url;
  String category_name;

  CategoryCardWidget({required this.image_url, required this.category_name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(image_url),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(category_name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
