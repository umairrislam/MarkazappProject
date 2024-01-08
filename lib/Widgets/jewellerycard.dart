import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Screens/jewellerycategorydetailscreen.dart';

class JewelleryCard extends StatelessWidget {
  final Items jewellerylistdata;
  const JewelleryCard({super.key ,required this.jewellerylistdata});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>JewelleryCategorydetailScreen(jewllerydetaildata:jewellerylistdata,)));
      },
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
                                        
                                        image: AssetImage("${jewellerylistdata.images}"),
                                        fit: BoxFit.fill,
                                      ), 
                 
                ),
                ),
              ),
              Center(
                child: Container(
                 
                  child:Text("${jewellerylistdata.text}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),maxLines: 1, overflow: TextOverflow.ellipsis,) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}