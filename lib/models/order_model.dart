

import 'package:e_commerc_mini_application/models/cart_item.dart';
import 'package:e_commerc_mini_application/models/product.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final DateTime orderDate;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.orderDate,

});

  //----[ toMap ]--Order-er object-ke Map-e convert kore, jeta pore JSON-e convert kora jabe.
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'items': items.map((item){
        return {
          'product' : {
            'id': item.product.id,
            'title':item.product.title,
            'price':item.product.price,
            'image':item.product.image,
            'category': item.product.category,
            'description':item.product.description,
            'rating': item.product.rating,
          },
          'quantity': item.quantity,
        };
      }).toList(),
      'totalPrice': totalPrice,
      'orderDate' : orderDate.toIso8601String(),
    };
  }

  //=====[ fromMap ]--Saved Map theke abar OrderModel object toiri kore.
factory OrderModel.fromMap(Map<String, dynamic>map){
    return OrderModel(
        id: map['id'],
        items: (map['items'] as List).map((item){
          final productMap = Map<String, dynamic>.from(item['product'] as Map);

          return CartItem(
              product: Product(
                  id: productMap['id'] as int,
                  title: productMap['title'] as String,
                  price: (productMap['price'] as num).toDouble(),
                  image: productMap['image'] as String,
                  category: productMap['category'] as String,
                  description: productMap['description'] as String,
                  rating: (productMap['rating'] as num).toDouble(),
              ),
          quantity: item['quantity'] as int,
          );
        }).toList(),

        totalPrice: (map['totalPrice'] as num).toDouble(),
        orderDate: DateTime.parse(map['orderDate'] as String));
}
}