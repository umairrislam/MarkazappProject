import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';

class NeclaceCard extends StatelessWidget {
  final Items neclacedata;
  const NeclaceCard({super.key ,required this.neclacedata});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
         
      child: Container(
      
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
    
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                 
                   width: 90,
                                     height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        
                                        image: NetworkImage("${neclacedata.images}"),
                                        fit: BoxFit.fill,
                                      ), 
                 
                ),
                ),
              ),
              Center(
                child: Container(
                 
                  child:Text("${neclacedata.text}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),maxLines: 1, overflow: TextOverflow.ellipsis,) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}