import 'package:flutter/material.dart';
import 'package:markazapp/Widgets/featured_gridviewcard.dart';

import 'package:markazapp/provider/featured_provider.dart';
import 'package:provider/provider.dart';

class FeatureGridView extends StatefulWidget {
  const FeatureGridView({super.key});

  @override
  State<FeatureGridView> createState() => _FeatureGridViewState();
}

class _FeatureGridViewState extends State<FeatureGridView> {
  @override
  void initState() {
    super.initState();
    Provider.of<FeaturedProvider>(context, listen: false)
        .getAllLatestfeaturelists();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Consumer<FeaturedProvider>(
        builder: (context, featureprovider, child) {
      if (featureprovider.isloading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.99,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 1 ,
              mainAxisSpacing: 4,
            ),
            itemCount: featureprovider.features.length,
            itemBuilder: (context, index) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GestureDetector(
                 
                  child: FeaturedGridViewCard(
                      fddata: featureprovider.features[index])),
            ),
          ),
        );
      } else {
        return Container();
      }
    }));
  }
}