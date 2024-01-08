import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Widgets/acessoriescard.dart';

class AccessoriesGridView extends StatefulWidget {
  const AccessoriesGridView({super.key});

  @override
  State<AccessoriesGridView> createState() => _AccessoriesGridViewState();
}

class _AccessoriesGridViewState extends State<AccessoriesGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height*0.99,
      child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:2,childAspectRatio: 0.9,
  mainAxisSpacing:9,
 ),
 itemCount:watchesslist.length ,
  itemBuilder: (context, index)=>SizedBox(
    height: MediaQuery.of(context).size.height*0.9,
    width: MediaQuery.of(context).size.width*0.3,
    child: GestureDetector(
      child: AccessoriesCard(accessoriesdata:watchesslist[index])),
  ),   
) ,
   
    ),
    );
  }
}