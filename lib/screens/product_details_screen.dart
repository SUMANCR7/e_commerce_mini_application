import 'package:e_commerc_mini_application/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
  required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Product Details'),
          actions: [
            IconButton(

                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                }, icon: Icon(Icons.shopping_cart))
          ],
        ),

       body: Column(
         children: [
           Image.network(
             product.image,
             height: 250,
             width: double.infinity,
             fit: BoxFit.contain,
           ),
           
           SizedBox(height: 20,),
           
           Container(
               padding: EdgeInsets.all(10),
               child: Text(product.title, style: TextStyle(fontSize: 24, fontWeight: .bold),)),

           SizedBox(height: 10,),

           Text('⭐ ${product.rating}',style: TextStyle(fontSize: 20,),),
           
           SizedBox(height: 10,),
           
           Text('\$${product.price}',style: TextStyle(fontSize: 22, fontWeight: .bold),),

           SizedBox(height: 20,),

           Container(
               padding: EdgeInsets.all(20),
               child: Text(product.description,style: TextStyle(fontSize: 18, fontWeight: .w500, color: Colors.grey.shade600),)),

           SizedBox(height: 24,),

           SizedBox(
             width: double.infinity,
             child: ElevatedButton.icon(
                 onPressed: (){
                   context.read<CartProvider>().addToCart(product);

                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Product added to cart'),
                     duration: Duration(seconds: 1),
                     )
                   );
                 },
                 icon: Icon(Icons.shopping_cart),
                 label: Text('Add to Cart')),
           ),

         ],
       ),
    );
  }
}
