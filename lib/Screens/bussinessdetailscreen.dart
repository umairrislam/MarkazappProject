import 'package:flutter/material.dart';

class BusinessDetailScreen extends StatefulWidget {
  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        appBar: AppBar(
           leading:IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ) ,
          centerTitle: true,
          title: Text('Bussiness Detail',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white, // Set the app bar color to white
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Business Name',style: TextStyle(fontSize: 12)),
              subtitle: Text(
                'Not Set',
                style: TextStyle(fontSize: 12,  color: Colors.green,),
              ),
              trailing: Icon(Icons.arrow_back_ios),
              onTap: () {
                // Handle tile tap
              },
            ),
            buildDivider(),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Business Name',style: TextStyle(fontSize: 12)),
              subtitle: Text(
                'Not Set',
                style: TextStyle(  fontSize: 12,  color: Colors.green),
              ),
              trailing: Icon(Icons.arrow_back_ios),
              onTap: () {
                // Handle tile tap
              },
            ),
            buildDivider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Want to be notified on Email?',style: TextStyle(fontSize: 12)),
              subtitle: Text(
                'Connect Gmail ID',
                style: TextStyle(fontSize: 12,   color: Colors.green),
              ),
              trailing: Icon(Icons.arrow_back_ios),
              onTap: () {
                // Handle email notification tap
              },
            ),
            buildDivider(),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Address',style: TextStyle(fontSize: 12)),
              subtitle: Text(
                'Not Set',
                style: TextStyle(fontSize: 12,  color: Colors.green),
              ),
              trailing: Icon(Icons.arrow_back_ios),
              onTap: () {
                // Handle tile tap
                print('Business 4 tapped');
              },
            ),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 0.5,
      height: 0,
    );
  }
}
