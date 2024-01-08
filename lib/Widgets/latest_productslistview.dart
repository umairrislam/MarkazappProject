import 'package:flutter/material.dart';


import 'package:markazapp/Widgets/latest_productscard.dart';
import 'package:markazapp/provider/Latestproduct_provider.dart';
import 'package:provider/provider.dart';

class LatestProductsListView extends StatefulWidget {
  const LatestProductsListView({super.key});

  @override
  State<LatestProductsListView> createState() => _LatestProductsListViewState();
}

class _LatestProductsListViewState extends State<LatestProductsListView> {
   @override
  void initState() {
    super.initState();
    Provider.of<LatestProductProvider>(context, listen: false)
        .getAllLatestproductslists();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<LatestProductProvider>(
        builder: (context, LatestProductProvider, child) {
      if (LatestProductProvider.isloading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: LatestProductCard(
                        latestData: LatestProductProvider.products[index]));
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 2,
                  ),
              itemCount: LatestProductProvider.products.length),
        );
      } else {
        return Container();
      }
    }));
  }
}