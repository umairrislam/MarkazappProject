import 'package:flutter/material.dart';
import 'package:markazapp/Screens/Categories_providerscreen.dart';

import 'package:markazapp/Screens/home_screen.dart';
import 'package:markazapp/Screens/order_screen.dart';

import 'package:markazapp/Screens/profile_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _currentIndex = 0;

  // Define your pages here
  final List<Widget> _pages = [
    HomeScreen(),
    CategoriesProviderScreen(),
    OrderScreen(),
    ProfileScreen(),
   
  ];
  String email = '', age = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
loadData()async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  email = sp.getString('username') ?? '';
  age = sp.getString('age') ?? '';
  setState(() {
    
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black38, // Set the unselected tab color to green
        backgroundColor: Colors.white, // Set the background color of the bar
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

