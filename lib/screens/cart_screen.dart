import 'package:e_commerc_mini_application/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),

      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;

          if (cartItems.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {

                    final item = cartItems[index];
                    final product = item.product;

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(
                          product.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),

                        title: Text(product.title),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('\$${product.price.toStringAsFixed(2)}'),
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                  cartProvider.decreaseQuantity(product);
                                }, icon: Icon(Icons.remove_circle_outline),),

                                Text('${item.quantity}',
                                style: TextStyle(fontSize: 16, fontWeight: .bold),
                                ),
                                IconButton(onPressed: (){
                                  cartProvider.addToCart(product);
                                }, icon: Icon(Icons.add_circle_outline))
                              ],
                            )
                          ],
                        ),





                        //---[ Delete Button ]
                        trailing: IconButton(
                          onPressed: () {
                            cartProvider.removeFromCart(item.product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Product removed from cart'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total Price: '
                          '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutScreen(),
                          ),
                        );
                      },
                      child: const Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              )

              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.all(20),
              //
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.surfaceContainerHighest,
              //   ),
              //   child: Text('Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
              //   style: TextStyle(fontSize: 20, fontWeight: .bold),
              //   ),
              //
              // )
            ],
          );
        },
      ),
    );
  }
}
