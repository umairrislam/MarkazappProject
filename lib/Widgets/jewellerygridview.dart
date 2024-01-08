import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';

import 'package:markazapp/Widgets/jewellerycard.dart';


class CategoryDetailPage extends StatefulWidget {
 
  const CategoryDetailPage({super.key,});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 1,
  mainAxisSpacing: 9,
 ),
 itemCount:jewellerylist.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.4,
    width: MediaQuery.of(context).size.width*0.7,
    child: GestureDetector(
       
      child: JewelleryCard(jewellerylistdata:jewellerylist[index])),
  ),   
) ,
   
    ),
    );
  }
}