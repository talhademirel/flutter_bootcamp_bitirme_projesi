import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/basket_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/food_detail_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/food_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/home_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/main_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/screen/home_page.dart';
import 'package:flutter_bitirme_projesi/ui/screen/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/cubit/product_page_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainPageCubit()),
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => FoodPageCubit()),
        BlocProvider(create: (context) => FoodDetailCubit()),
        BlocProvider(create: (context) => BasketPageCubit()),
        BlocProvider(create: (context) => ProductPageCubit()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}

