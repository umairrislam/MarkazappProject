import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Screens/womenstichedDetailscreen.dart';

class WomensStichedCard extends StatelessWidget {
  final Items womensticheddata;
  const WomensStichedCard({super.key,required this.womensticheddata});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WomenStichedDetailScreen(womenssticheddata:womensticheddata,)));
      },
      child: Container(
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
                                        
                                        image: AssetImage("${womensticheddata.images}"),
                                        fit: BoxFit.cover,
                                      ), 
                 
                ),
                ),
              ),
              Center(
                child: Container(
                 
                  child:Text("${womensticheddata.text}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),maxLines: 1, overflow: TextOverflow.ellipsis,) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}