
import 'package:e_commerc_mini_application/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProviders extends ChangeNotifier{
  final ProductRepository repository;
  //--Provider-এর ভিতরে products রাখার জন্য
  List<Product> products = [];
  List<String> categories = [];
  bool isLoading = false;

  ProductProviders({
    required this.repository,
  });

  //---- [get Products ] method
  Future<void> getProducts() async{
    isLoading = true; // start API call
    notifyListeners();//"UI, আমার data change হয়েছে—তুমি update হও!" 🔔

    try{
      products = await repository.getProducts(); //Repository API থেকে Product এনে products list-এ রাখবে।
    }catch (e){
      debugPrint(e.toString());
    }finally{
      isLoading = false;//Data আসুক বা error হোক—loading শেষ করতে হবে।
      notifyListeners();
    }
  }
// Important connection== API-->Dio-->Repository-->Provider-->UI

//---[ get product By Id ] method
Future<Product> getProductById(int id) async{
    return await repository.getProductById(id); // এখানে await দিয়ে Repository থেকে Product আসা পর্যন্ত অপেক্ষা করছি।
}

//---[ getCategories] method
Future<void> getCategories() async{
    categories = await repository.getCategories();
    notifyListeners();
}

}

