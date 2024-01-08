import 'package:flutter/material.dart';
import 'package:markazapp/Screens/categories_postscreen.dart';
import 'package:markazapp/Widgets/Category_Card.dart';
import 'package:markazapp/provider/categories_provider.dart';
import 'package:provider/provider.dart';

class CategorieslistView extends StatefulWidget {
  const CategorieslistView({super.key});

  @override
  State<CategorieslistView> createState() => _CategorieslistViewState();
}

class _CategorieslistViewState extends State<CategorieslistView> {
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
                                  builder: (context) => CategoriesPostScreen(
                                      catPostId: categoriesProvider
                                          .categoriies[index].id!)));
                        },
                        child: CategoriesCard(
                            categorydata: categoriesProvider.categoriies[index])));
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 2,
                  ),
              itemCount: categoriesProvider.categoriies.length),
        );
      } else {
        return Container();
      }
    }));
  }
}
