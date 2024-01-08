import 'package:flutter/material.dart';
import 'package:markazapp/Screens/categories_postdetailscreen.dart';
import 'package:markazapp/Screens/details_screen.dart';
import 'package:markazapp/provider/categories_provider.dart';
import 'package:markazapp/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class CategoriesProviderScreen extends StatefulWidget {
  @override
  State<CategoriesProviderScreen> createState() => _CategoriesProviderScreenState();
}

class _CategoriesProviderScreenState extends State<CategoriesProviderScreen> {
  int currentIndex = 0;
  String selectedCategoryName = "";

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getAllcategorieslists();
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat.yMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(
          backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text("Markaz"),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // Text above categories
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Consumer<CategoriesProvider>(
                          builder: (context, Categoriesprovider, child) {
                            if (Categoriesprovider.isloading) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height * 0.99,
                                child: ListView.separated(
                                  itemCount: Categoriesprovider.categoriies.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.03,
                                    );
                                  },
                                  itemBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: MediaQuery.of(context).size.height * 0.12,
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            currentIndex = index;
                                            selectedCategoryName = Categoriesprovider.categoriies[index].name.toString();
                                          });

                                          String categoryId = Categoriesprovider.categoriies[index].id!.toString();
                                          await Provider.of<Productprovider>(
                                            context,
                                            listen: false,
                                          ).getCatPost(categoryId);
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage("${Categoriesprovider.categoriies[index].imageUrl}"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(8.0),
                                                        bottomLeft: Radius.circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: currentIndex == index ? Colors.orange : Colors.transparent,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      width: 80,
                                                      height: 25,
                                                      child: Center(
                                                        child: Text(
                                                          "${Categoriesprovider.categoriies[index].name}",
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: currentIndex == index ? Colors.white : Colors.black,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.005,
                        height: MediaQuery.of(context).size.height * 0.99,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text above products
                            Text(
                              'Products',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            // Display selected category name
                            Text(
                              selectedCategoryName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                             SizedBox(height: 3),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.99 - 60, // Adjust the height
                              child: Consumer<Productprovider>(
                                builder: (context, productProvider, child) {
                                  if (productProvider.isloading) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  return GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0.2,
                                      childAspectRatio: 0.9,
                                      mainAxisSpacing: 0.1,
                                    ),
                                    itemCount: productProvider.products.length,
                                    itemBuilder: (context, index) {
                                      final products = productProvider.products[index];
                                      return SizedBox(
                                        width: 90,
                                        height: MediaQuery.of(context).size.height * 0.2,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => detailProductScreen(
                                                  latestdetaildata: products,
                                                  categoryId: productProvider.products[index].id!,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 30,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: CachedNetworkImage(
                                                        imageUrl: "${products.images?[0].src}",
                                                        placeholder: (context, url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      width: 100,
                                                      child: Text(
                                                        "${products.name}",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
