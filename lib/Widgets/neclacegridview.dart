import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/neclacecard.dart';

class NeclaceGridView extends StatefulWidget {
  const NeclaceGridView({super.key});

  @override
  State<NeclaceGridView> createState() => _NeclaceGridViewState();
}

class _NeclaceGridViewState extends State<NeclaceGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 1,
  mainAxisSpacing: 9,
 ),
 itemCount:jewllerydetaildatalist.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.4,
    width: MediaQuery.of(context).size.width*0.7,
    child: GestureDetector(
       
      child: NeclaceCard(neclacedata:jewllerydetaildatalist[index])),
  ),   
) ,
   
    ),
    );
  }
}