import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bitirme_projesi/data/repo/foods_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPageCubit extends Cubit<List<QueryDocumentSnapshot>> {
  ProductPageCubit():super(<QueryDocumentSnapshot>[]);

  var foodsRepo = FoodsRepository();

  Future<void> getProducts(int id) async {
    var list = await foodsRepo.getProducts(id);
    emit(list);
  }
}