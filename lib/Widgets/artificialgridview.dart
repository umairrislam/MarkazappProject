import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/artificialsetcard.dart';

class ArtificialGridView extends StatefulWidget {
  const ArtificialGridView({super.key});

  @override
  State<ArtificialGridView> createState() => _ArtificialGridViewState();
}

class _ArtificialGridViewState extends State<ArtificialGridView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 0.9,
  mainAxisSpacing:9,
 ),
 itemCount:artificialsetslists.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.9,
    width: MediaQuery.of(context).size.width*0.5,
    child: GestureDetector(
      child: ArtificialSetsCard(artificalsetdata:artificialsetslists[index])),
  ),   
) ,
   
    ),
    );
  }
}