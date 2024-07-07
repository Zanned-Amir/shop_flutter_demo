import 'package:flutter/material.dart';
import 'package:shop_app_flutter/global_variables.dart';
import 'package:shop_app_flutter/widgets/product_card.dart';
import 'package:shop_app_flutter/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
const ProductList({ Key? key }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {


  late String selectedFilter;
  final List<String> filters = const  [
    'All',
    'Adidas',
    'Nike',
    'Puma',
  ];


   @override
  void initState(){
    super.initState();
    selectedFilter = filters.first;
  }


  @override
  Widget build(BuildContext context){
    

     final  border =  OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(215, 212, 212, 1),
      ),
      borderRadius: BorderRadius.circular(50),
    );

    return   SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child:  Text(
                    'shop',
                    style: Theme.of(context).textTheme.titleLarge,       
                   ),
                 ),
                 Expanded(
                 child: Container(
                  
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                      ),
                   ),
                 ),  
                )
                
              ]
            ),
            SizedBox(
              height: 120,
            
              child: ListView.builder(
                    itemCount: filters.length,
                    scrollDirection: Axis.horizontal,  
                    itemBuilder: (context , index ){
                      final filter = filters[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: (){
                          setState(() {
                            selectedFilter = filter;
                            print(selectedFilter);
                          });
                        },
                          child: Chip(
                            backgroundColor: selectedFilter == filter ? 
                            Theme.of(context).colorScheme.primary : Color.fromRGBO(241, 247, 249, 1),
                            side: const BorderSide(
                              color: const Color.fromRGBO(241, 247, 249, 1),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                              ),
                            label: Text(filter),
                            labelStyle: TextStyle(
                            fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),            
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            ),
          

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (  constraints.maxWidth > 1080 ) {
              
                    return  GridView.builder(
                                      itemCount: products.length,
                                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     childAspectRatio: 2,
                                      ),
                                      itemBuilder: (context , index) {
                    final product = products[index] ;
                    return GestureDetector(
                       onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                           builder: (context)  {
                             return ProductDetailsPage(product: product);
                           }
                         ));
                       },
                      child: ProductCard(
                       title: product['title'] as String,
                       price: product['price'] as double,
                       image: product['imageUrl'] as String , 
                       backgroundColor: index.isEven ?  
                       const Color.fromRGBO(216,240,253,1) : const Color.fromRGBO(241,247,249,1),
                      ),
                    );
                                    }
                                      
                                    );
                  }
                  else {
              
                    return ListView.builder(
                itemCount: products.length ,
                itemBuilder: (context , index) {
                   final product = products[index] ;
                   return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)  {
                            return ProductDetailsPage(product: product);
                          }
                        ));
                      },
                     child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String , 
                      backgroundColor: index.isEven ?  
                      const Color.fromRGBO(216,240,253,1) : const Color.fromRGBO(241,247,249,1),
                     ),
                   );
                }
                );
                    
                  }
              
                }
              ),
            ),
             

          ],
        ),
        
      );
  }
}