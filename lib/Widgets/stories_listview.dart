import 'package:flutter/material.dart';

import 'package:markazapp/Widgets/stories_card.dart';
import 'package:markazapp/provider/categories_provider.dart';
import 'package:provider/provider.dart';

class StorieslistView extends StatefulWidget {
  const StorieslistView({super.key});

  @override
  State<StorieslistView> createState() => _StorieslistViewState();
}
 

class _StorieslistViewState extends State<StorieslistView> {
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
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: GestureDetector(
                       
                        child: StoriesCard(
                            stories: categoriesProvider.categoriies[index])));
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