import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/womensunstichedcard.dart';

class WomensunStichedGridView extends StatefulWidget {
  const WomensunStichedGridView({super.key});

  @override
  State<WomensunStichedGridView> createState() => _WomensunStichedGridViewState();
}

class _WomensunStichedGridViewState extends State<WomensunStichedGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 0.7,
  mainAxisSpacing:9,
 ),
 itemCount:womensunstichedlist.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.7,
    width: MediaQuery.of(context).size.width*0.7,
    child: GestureDetector(
      child: WomensunstichedCard(womensunsticheddata:womensunstichedlist[index])),
  ),   
) ,
   
    ),
    );
  }
}