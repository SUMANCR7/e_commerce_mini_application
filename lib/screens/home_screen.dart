import 'package:e_commerc_mini_application/providers/product_providers.dart';
import 'package:e_commerc_mini_application/screens/order_history_screen.dart';
import 'package:e_commerc_mini_application/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductProviders>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryScreen()));

          }, icon: Icon(Icons.history),
          tooltip: 'Order History',
          )
        ],
      ),

      body: Consumer<ProductProviders>(
        builder: (context, provider, child){
          return ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index){
                final product = provider.products[index];

                return Card(
                  child: ListTile(
                    //--Home Screen-->>> Product details screen
                      onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=>ProductDetailsScreen(product: product)));
                    },

                    leading: Image.network(
                      product.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$${product.price}'),
                        Text('⭐ ${product.rating}'),
                      ],
                    )


                  ),
                );
              },
              );
        },
      ),
    );
  }
}
