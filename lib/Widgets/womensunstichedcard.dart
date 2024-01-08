import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';

class WomensunstichedCard extends StatelessWidget {
  final Items womensunsticheddata;
  const WomensunstichedCard({super.key,required this.womensunsticheddata});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               
                 width: 90,
                                   height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      
                                      image: AssetImage("${womensunsticheddata.images}"),
                                      fit: BoxFit.cover,
                                    ), 
               
              ),
              ),
            ),
            Center(
              child: Container(
               
                child:Text("${womensunsticheddata.text}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),maxLines: 1, overflow: TextOverflow.ellipsis,) ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}