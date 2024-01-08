import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/beddingcard.dart';

class BeddingGridView extends StatefulWidget {
  const BeddingGridView({super.key});

  @override
  State<BeddingGridView> createState() => _BeddingGridViewState();
}

class _BeddingGridViewState extends State<BeddingGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 0.9,
  mainAxisSpacing:9,
 ),
 itemCount:beddinglists.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.9,
    width: MediaQuery.of(context).size.width*0.5,
    child: GestureDetector(
      child: BeddingCard(beddingdata:beddinglists[index])),
  ),   
) ,
   
    ),
    );
  }
}