import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/menstichedcard.dart';

class MenstichedGridView extends StatefulWidget {
  const MenstichedGridView({super.key});

  @override
  State<MenstichedGridView> createState() => _MenstichedGridViewState();
}

class _MenstichedGridViewState extends State<MenstichedGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 0.9,
  mainAxisSpacing:9,
 ),
 itemCount:mensstichedlists.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.9,
    width: MediaQuery.of(context).size.width*0.5,
    child: GestureDetector(
      child: MenstichedCard(menssticheddata:mensstichedlists[index])),
  ),   
) ,
   
    ),
    );
  }
}