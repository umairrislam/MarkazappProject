import 'package:flutter/material.dart';
import 'package:markazapp/Widgets/accesoriesgridview.dart';
import 'package:markazapp/Widgets/beddinggridview.dart';
import 'package:markazapp/Widgets/jewellerygridview.dart';
import 'package:markazapp/Widgets/menstichedgridview.dart';
import 'package:markazapp/Widgets/shoesgridview.dart';
import 'package:markazapp/Widgets/womenstichedgridview.dart';
import 'package:markazapp/Widgets/womenunstichedgridview.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Widget> _mainContents = [
    Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: CategoryDetailPage()),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: WomensunStichedGridView(),
    ),
    Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: WomenstichedGridView()),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: AccessoriesGridView(),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: ShoesGridView(),
    ),
    Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: BeddingGridView()),
    Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: MenstichedGridView()),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Markaz",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Row(
        children: [
          // Place the NavigationRail on the left side
          NavigationRail(
            minWidth: 0.2,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: const TextStyle(
              color: Colors.green,
            ),

            unselectedLabelTextStyle: const TextStyle(color: Colors.black38),
            backgroundColor: Colors.grey[200],
            // Use Image.asset for images from assets
            destinations: [
              NavigationRailDestination(
                icon: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      'assets/images/jewlery.png'), // Replace with your asset path
                ),
                label: Container(
                    width: 60,
                    child: Text('Jewellery',
                        maxLines: 1, overflow: TextOverflow.ellipsis)),
              ),
              NavigationRailDestination(
                icon: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      'assets/images/unsticheddressgirls.png'), // Replace with your asset path
                ),
                label: Container(
                    width: 70,
                    child: Text("Women's Unstiched",
                        maxLines: 2, overflow: TextOverflow.ellipsis)),
              ),
              NavigationRailDestination(
                icon: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      'assets/images/sticheddressgirls.png'), // Replace with your asset path
                ),
                label: Container(
                    width: 70,
                    child: Text("Women's Stiched",
                        maxLines: 2, overflow: TextOverflow.ellipsis)),
              ),
              NavigationRailDestination(
                icon: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      'assets/images/watch.png'), // Replace with your asset path
                ),
                label: Text("Accessories"),
              ),
              NavigationRailDestination(
                icon: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      'assets/images/femaleshoes.png'), // Replace with your asset path
                ),
                label: Text("Shoes"),
              ),
              NavigationRailDestination(
                icon: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      'assets/images/bedd.png'), // Replace with your asset path
                ),
                label: Text("Bedding"),
              ),
              NavigationRailDestination(
                icon: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      'assets/images/dressmens.png'), // Replace with your asset path
                ),
                label: Container(
                    width: 50,
                    child: Text("Men's Stiched",
                        maxLines: 2, overflow: TextOverflow.ellipsis)),
              ),
            ],
          ),

          // Main content
          Expanded(child: _mainContents[_selectedIndex]),
        ],
      ),
    );
  }
}
