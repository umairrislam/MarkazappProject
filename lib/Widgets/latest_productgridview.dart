import 'package:flutter/material.dart';

import 'package:markazapp/Widgets/latest_productgridviewcard.dart';

import 'package:markazapp/provider/Latestproduct_provider.dart';
import 'package:provider/provider.dart';


class LatestProductsGridView extends StatefulWidget {
  const LatestProductsGridView({super.key});

  @override
  State<LatestProductsGridView> createState() => _LatestProductsGridViewState();
}

class _LatestProductsGridViewState extends State<LatestProductsGridView> {
   @override
  void initState() {
    super.initState();
    Provider.of<LatestProductProvider>(context, listen: false)
        .getAllLatestproductslists();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<LatestProductProvider>(
        builder: (context, LatestproductProvider, child) {
      if (LatestproductProvider.isloading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.99,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.92,
              mainAxisSpacing: 4,
            ),
            itemCount: LatestproductProvider.products.length,
            itemBuilder: (context, index) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GestureDetector(
                    
                  child: LatestProductGridViewCard(
                     gdata: LatestproductProvider.products[index])),
            ),
          ),
        );
      } else {
        return Container();
      }
    }));
  }
}