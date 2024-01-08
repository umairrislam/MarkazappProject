import 'package:flutter/material.dart';
import 'package:markazapp/Widgets/Categories_gridview.dart';


class CategoriesSeeALLScreen extends StatefulWidget {
  const CategoriesSeeALLScreen({super.key});

  @override
  State<CategoriesSeeALLScreen> createState() => _CategoriesSeeALLScreenState();
}

class _CategoriesSeeALLScreenState extends State<CategoriesSeeALLScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle:true ,
        title: Text("Markaz",style: TextStyle(color: Colors.black),),
      
       backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.999,
             width: MediaQuery.of(context).size.width,
             child: CategoriesGridView(),
          ),
        ],
          ),
      ),
    );
  }
}