import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';

class TopCategoriesCard extends StatelessWidget {
  final Items categoryylistdata;
  const TopCategoriesCard({super.key ,required this.categoryylistdata});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               
                 width: 40,
                                   height: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      
                                      image: AssetImage("${categoryylistdata.images}"),
                                      fit: BoxFit.cover,
                                    ), 
               
              ),
              ),
            ),
            Center(
              child: Container(
               
                child:Text("${categoryylistdata.text}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),maxLines: 1, overflow: TextOverflow.ellipsis,) ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}