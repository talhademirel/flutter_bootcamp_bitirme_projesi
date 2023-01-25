import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bitirme_projesi/data/repo/foods_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<List<QueryDocumentSnapshot>> {
  HomePageCubit():super(<QueryDocumentSnapshot>[]);

  var foodsRepo = FoodsRepository();

  Future<void> getCategorys() async {
    var list = await foodsRepo.getCategorys();
    emit(list);
  }
}