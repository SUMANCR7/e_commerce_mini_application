//--- Worker Bring Data

import 'package:dio/dio.dart';
import 'package:e_commerc_mini_application/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(int id);
  Future<List<String>> getCategories();
}

class ProductRepositoryImpl implements ProductRepository{
  final Dio dio;
  ProductRepositoryImpl({
   required this.dio,
});

  //---getProduct method
  @override
  Future<List<Product>> getProducts() async{  // Many product
    try {
      //--API call
      final response = await dio.get(
        'https://dummyjson.com/products',
      );

      final data = response.data;
      final products = data['products'] as List;

      return products.map((item) => Product.fromMap(item)).toList();
    }catch (e){
      throw Exception('Failed to fetch products');
    }
  }

  //----[get Product by Id] method
  @override
  Future<Product> getProductById(int id) async{ // Single product
    try{
      //--API call
      final response = await dio.get(
          'https://dummyjson.com/products/$id',
      );

      return Product.fromMap(response.data);
    }catch (e){
      throw Exception('Failed to fetch products');
    }
  }

  //----[ get Categories ] method
  @override
Future<List<String>> getCategories() async{
    try{
      final response = await dio.get(
        'https://dummyjson.com/products/categories'
      );

      final data = response.data as List;

      return data.map((item)=>item.toString()).toList();

    }catch (e){
      throw Exception('Failed to fetch categories');
    }
}

}