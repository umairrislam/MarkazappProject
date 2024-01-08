import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/womensstichedcard.dart';


class WomenstichedGridView extends StatefulWidget {
  const WomenstichedGridView({super.key});

  @override
  State<WomenstichedGridView> createState() => _WomenstichedGridViewState();
}

class _WomenstichedGridViewState extends State<WomenstichedGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 0.7,
  mainAxisSpacing:9,
 ),
 itemCount:womensstichedlist.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.7,
    width: MediaQuery.of(context).size.width*0.7,
    child: GestureDetector(
      child: WomensStichedCard(womensticheddata:womensstichedlist[index])),
  ),   
) ,
   
    ),
    );
  }
}