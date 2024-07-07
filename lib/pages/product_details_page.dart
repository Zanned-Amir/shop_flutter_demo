import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';


class ProductDetailsPage extends StatefulWidget {
  final Map<String , Object > product;
  const ProductDetailsPage({ 
    super.key ,
    required this.product
    });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  
  int? selectedSize = null;

  void onTap() {
     if (selectedSize != null) {
      Provider.of<CartProvider>(context , listen: false).addProduct(
      {
    'id': widget.product['id'],
    'title': widget.product['title'],
    'price': widget.product['price'],
    'size': selectedSize ,
    'company': widget.product['company'],
    'imageUrl': widget.product['imageUrl'],
    'quantity': widget.product['quantity'],
      }
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully'),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a size'),
        ),
      );
    }
  }
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Details')),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String ,
             style: Theme.of(context).textTheme.titleLarge
             ),
             const Spacer(),
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                widget.product['imageUrl'] as String,
                height: 200,
              ),
             ),
              const Spacer(flex:2),
              Container(
                height: 250 ,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(245,247,249,1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$${widget.product['price']}',
                    style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height:10),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                    
                        scrollDirection: Axis.horizontal,
                        itemCount: (widget.product['sizes'] as List<int>).length,
                        itemBuilder: (context , index) {
                          final size = (widget.product['sizes'] as List<int>)[index];
                      
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = index;
                                });
                              },
                              child: Chip(
                                label: Text(size.toString()),
                                backgroundColor: selectedSize == index ? 
                                Theme.of(context).colorScheme.primary : null,
                              ),
                            ),
                          );
                        } 
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: (){
                          onTap();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          fixedSize: const Size(350, 50),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    )],
                )
              ),

       
        ],
      ),
    );
  }
}