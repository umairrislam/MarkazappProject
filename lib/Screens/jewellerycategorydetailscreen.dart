import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/neclacegridview.dart';

class JewelleryCategorydetailScreen extends StatefulWidget {
  final Items jewllerydetaildata;
  const JewelleryCategorydetailScreen({super.key,required this.jewllerydetaildata});

  @override
  State<JewelleryCategorydetailScreen> createState() => _JewelleryCategorydetailScreenState();
}

class _JewelleryCategorydetailScreenState extends State<JewelleryCategorydetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Markaz',

              
              style: TextStyle(color: Colors.black), // Set title text color
            ),
            backgroundColor: Colors.white, // Set app bar background color
            bottom: TabBar(
              
              tabs: [
                
                Tab(
                  
                  text: 'Items',
                  
                  // Set tab text color
                  // You can also use labelColor property to set text color for all tabs
                  // labelColor: Colors.black,
                ),
                Tab(
                  text: 'Catlogs',
                  // Set tab text color
                  // labelColor: Colors.black,
                ),
              ],
              labelColor: Colors.black, // Set the common text color for tabs
            ),
          ),
          body: TabBarView(
            children: [
              // Content for the 'Pending' tab
              Center(
                child: NeclaceGridView(),
              ),

              // Content for the 'Paid' tab
              Center(
                child: Text('Catalogs'),
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
}