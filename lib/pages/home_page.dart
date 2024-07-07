import 'package:flutter/material.dart';
import 'package:shop_app_flutter/pages/cart_page.dart';
import 'package:shop_app_flutter/global_variables.dart';
import 'package:shop_app_flutter/widgets/product_card.dart';
import 'package:shop_app_flutter/pages/product_details_page.dart';
import 'package:shop_app_flutter/widgets/product_list.dart';
import 'package:shop_app_flutter/pages/profile_page.dart';


class HomePage extends StatefulWidget {
const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  
  List<Widget> pages = const [
    ProductList(),
    CartPage(),
    ProfilePage(),
  ];
 

  @override
  Widget build(BuildContext context){

   
    return  Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
              ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          }
        );
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ]
      )

    );
  }
}