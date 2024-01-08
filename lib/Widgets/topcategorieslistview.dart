import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/topcategoriescard.dart';

class TopcategorieslistView extends StatelessWidget {
  const TopcategorieslistView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(

      width: MediaQuery.of(context).size.width*0.9,
      child: ListView.separated (
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){

        return SizedBox(
          height: MediaQuery.of(context).size.height*0.18,
        width: MediaQuery.of(context).size.width*0.28,
          child: TopCategoriesCard(categoryylistdata: topcategorieslist[index]));
      }, separatorBuilder: (context, index)=>
         SizedBox(width:5,),
      itemCount:topcategorieslist.length),
    ) ;
  }
}