import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';

class ArtificialSetsCard extends StatelessWidget {
  final Items artificalsetdata;
  const ArtificialSetsCard({super.key ,required this.artificalsetdata});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               
                width:100,
                height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      
                                      image: NetworkImage("${artificalsetdata.images}"),
                                      fit: BoxFit.fill,
                                    ), 
               
              ),
              ),
            ),
            Center(
              child: Container(
               
                child:Text("${artificalsetdata.text}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),maxLines: 1, overflow: TextOverflow.ellipsis,) ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}