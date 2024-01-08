import 'package:flutter/material.dart';
import 'package:markazapp/Screens/featured_productsdetailscreen.dart';

import 'package:markazapp/Widgets/Featured_card.dart';
import 'package:markazapp/provider/featured_provider.dart';
import 'package:provider/provider.dart';

class FeaturelistView extends StatefulWidget {
  const FeaturelistView({super.key});

  @override
  State<FeaturelistView> createState() => _FeaturelistViewState();
}

class _FeaturelistViewState extends State<FeaturelistView> {
   @override
  void initState() {
    super.initState();
    Provider.of<FeaturedProvider>(context, listen: false)
        .getAllLatestfeaturelists();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<FeaturedProvider>(
        builder: (context, featuredPovider, child) {
      if (featuredPovider.isloading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.39,
                    child: GestureDetector(
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeaturedProductsDetailScreen(fdata: featuredPovider.features[index]),
                        ),
                      );
                    },
                        child: FeaturedCard(
                          featuremodeldata: featuredPovider.features[index])));
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 2,
                  ),
              itemCount: featuredPovider.features.length),
        );
      } else {
        return Container();
      }
    }));
  }
}