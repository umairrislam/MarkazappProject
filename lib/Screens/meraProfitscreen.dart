import 'package:flutter/material.dart';

class MeraProfitScreen extends StatefulWidget {
  @override
  State<MeraProfitScreen> createState() => _MeraProfitScreenState();
}

class _MeraProfitScreenState extends State<MeraProfitScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
             leading:IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ) ,
            centerTitle: true,
            title: Text(
              'Mera Profit',

              
              style: TextStyle(color: Colors.black), // Set title text color
            ),
            backgroundColor: Colors.white, // Set app bar background color
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Pending',
                  // Set tab text color
                  // You can also use labelColor property to set text color for all tabs
                  // labelColor: Colors.black,
                ),
                Tab(
                  text: 'Paid',
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
                child: Text('Pending Content'),
              ),

              // Content for the 'Paid' tab
              Center(
                child: Text('Paid Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
