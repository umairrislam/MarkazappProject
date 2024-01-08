import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:markazapp/Screens/cartscreen.dart';


import 'package:markazapp/Screens/categories_seeallscreen.dart';
import 'package:markazapp/Screens/enterpriseSeeallscreen.dart';

import 'package:markazapp/Widgets/Categories_listview.dart';
import 'package:markazapp/Widgets/latest_productslistview.dart';
import 'package:markazapp/Widgets/Featured_gridview.dart';
import 'package:markazapp/Widgets/Featured_listview.dart';
import 'package:markazapp/Widgets/stories_listview.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    "assets/images/Enginepic.png",
    "assets/images/taillight.png",
    "assets/images/headlight.png",
    "assets/images/engss.png",
  ];
   
   

   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      
        backgroundColor: Colors.white,
        title: Text(
          "Markaz",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
         IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.red),
            onPressed: () {
              
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen()));  
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.red),
            onPressed: () {
             
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: StorieslistView(),
                  ),
                ),
                CarouselSlider(
                  items: images.asMap().entries.map((entry) {
                    int index = entry.key;
                    String item = entry.value;
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              item,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 1.1,
                    reverse: false,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    viewportFraction: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoriesSeeALLScreen()));
                        },
                        child: Row(
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: CategorieslistView()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Latest Products',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LatestProductsSeeAllScreen()));
                        },
                        child: Row(
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: LatestProductsListView(),
                  ),
                ),
              /*  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Top Categories',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoriesScreen()));
                        },
                        child: Row(
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: TopcategorieslistView(),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Featured Products',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeatureGridView()));
                        },
                        child: Row(
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: FeaturelistView(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
