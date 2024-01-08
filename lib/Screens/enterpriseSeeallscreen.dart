import 'package:flutter/material.dart';
import 'package:markazapp/Widgets/latest_productgridview.dart';


class LatestProductsSeeAllScreen extends StatefulWidget {
  const LatestProductsSeeAllScreen({super.key});

  @override
  State<LatestProductsSeeAllScreen> createState() => _LatestProductsSeeAllScreenState();
}

class _LatestProductsSeeAllScreenState extends State<LatestProductsSeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           child: LatestProductsGridView(),
        ),
      ],
    );
  }
}