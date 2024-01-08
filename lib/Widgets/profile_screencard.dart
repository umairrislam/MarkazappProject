import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
 void _showBottomSheet() {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 220,
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Sales',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Text('Monthly'),
              ],
            ),
            Row(
              children: [
                Radio(
                  
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                       
                    });
                  },
                ),
                Text('All Time'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Selected Option: $_selectedValue');
                    Navigator.pop(context);
                    
                  },
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 80,
                     
                      decoration: BoxDecoration(
                        color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(child: Text("Apply",style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            )
          
          ], // Closing the Column here
        ),
      );
    },
  );
}


  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.purple,
              Colors.green,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: _showBottomSheet,
              child: Container(
                width: 80,
                height: 34,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  'All Time',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
          
            Text("Rs.0",style: TextStyle(color: Colors.white,fontSize: 18),),
            SizedBox(height: 10,),
              Text("Total Sales",style: TextStyle(color: Colors.white,fontSize: 12),),
SizedBox(height: 10,),
 Divider(
               color: Colors.grey, 
      thickness: 0.5,
      height: 0,
            ),
            SizedBox(height: 10,),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(color: Colors.white ,fontSize: 13),

                    ),
                    SizedBox(height: 5,),
                      Text("Completed",style: TextStyle(color: Colors.white,fontSize: 13),),
        SizedBox(height: 5,),
                      Text("Orders",style: TextStyle(color: Colors.white,fontSize: 13),),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Rs 0',
                      style: TextStyle(color: Colors.white,fontSize: 13),
                    ),
                     SizedBox(height: 5,),
                      Text("Total",style: TextStyle(color: Colors.white,fontSize: 13),),
                   SizedBox(height: 5,),
                      Text("Profit",style: TextStyle(color: Colors.white,fontSize: 13),),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Rs 0',
                      style: TextStyle(color: Colors.white,fontSize: 13),
                    ),
                     SizedBox(height: 5,),
                      Text("Total",style: TextStyle(color: Colors.white,fontSize: 13),),
                  SizedBox(height: 5,),
                      Text("Bonus",style: TextStyle(color: Colors.white,fontSize: 13),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
