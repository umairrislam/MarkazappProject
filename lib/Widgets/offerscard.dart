import 'package:flutter/material.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height:9,
    
        decoration: BoxDecoration(
          
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 60,
              height: 40,
              child: Image.network("https://freepngimg.com/thumb/gift/10-gift-box-png-image.png"),
            ),
          ),
          Text(
            'MyOffers',
            style: TextStyle(
              fontSize: 15,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,),
          Container(
           width: 70,
           height: 30,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'O Active',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}