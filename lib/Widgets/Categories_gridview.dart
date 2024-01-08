import 'package:flutter/material.dart';
import 'package:markazapp/Screens/categories_postscreen.dart';

import 'package:markazapp/Widgets/Category_Card.dart';
import 'package:markazapp/provider/categories_provider.dart';
import 'package:provider/provider.dart';

class CategoriesGridView extends StatefulWidget {
  const CategoriesGridView({super.key});

  @override
  State<CategoriesGridView> createState() => _CategoriesGridViewState();
}

class _CategoriesGridViewState extends State<CategoriesGridView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false)
        .getAllcategorieslists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<CategoriesProvider>(
        builder: (context, categoriesProvider, child) {
      if (categoriesProvider.isloading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.99,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 1.1,
              mainAxisSpacing: 4,
            ),
            itemCount: categoriesProvider.categoriies.length,
            itemBuilder: (context, index) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesPostScreen(
                                catPostId: categoriesProvider
                                    .categoriies[index].id!)));
                  },
                  child: CategoriesCard(
                      categorydata: categoriesProvider.categoriies[index])),
            ),
          ),
        );
      } else {
        return Container();
      }
    }));
  }
}
