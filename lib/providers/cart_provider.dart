import 'package:e_commerc_mini_application/models/cart_item.dart';
import 'package:e_commerc_mini_application/models/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(Product product) {
    final index = cartItems.indexWhere(
        (item) => item.product.id == product.id,
    );

    if(index >= 0){
      cartItems[index].quantity++;
    }else{
      cartItems.add(
        CartItem(product: product),
      );
    }

    notifyListeners();
  }

  void decreaseQuantity(Product product){
    final index = cartItems.indexWhere(
        (item) => item.product.id == product.id,
    );
    if(index == -1) return;

    if(cartItems[index].quantity > 1){
      cartItems[index].quantity--;
      notifyListeners();
    }

  }

  void removeFromCart(Product product) {
    cartItems.removeWhere(
        (item)=> item.product.id == product.id,
    );
    notifyListeners();
  }

  double get totalPrice {
    return cartItems.fold(0.0, (total, item) => total + (item.product.price * item.quantity) );
  }

  void clearCart(){
    cartItems.clear();
    notifyListeners();
  }

}
