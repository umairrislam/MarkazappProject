import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:markazapp/Screens/details_screen.dart';

import 'package:markazapp/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CategoriesPostScreen extends StatefulWidget {
  final int catPostId;

  const CategoriesPostScreen({Key? key, required this.catPostId}) : super(key: key);

  @override
  State<CategoriesPostScreen> createState() => _CategoriesPostScreenState();
}

class _CategoriesPostScreenState extends State<CategoriesPostScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the API call when the screen initializes
    Provider.of<Productprovider>(context, listen: false).getCatPost(widget.catPostId);
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Colors.white,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Consumer<Productprovider>(
          builder: (context, postprovider, child) {
            
            if (postprovider.isloading) {
              // Display a loading indicator while data is being fetched
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Display the fetched data in a GridView
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 6,
                  childAspectRatio: 0.9,
                ),
                itemCount: postprovider.products.length,
                itemBuilder: (context, index) {
                  final product = postprovider.products[index];
                  
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => detailProductScreen(latestdetaildata: product,categoryId:postprovider.products[index].id!),
                        ),
                      );
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      elevation: 2,
                      child:Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               width: 100,
                               height: 85,
                               child: CachedNetworkImage(
                                 imageUrl: "${product.images?[0].src}",
                                 placeholder: (context, url) => CircularProgressIndicator(),
                                 errorWidget: (context, url, error) => Icon(Icons.error),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                           Center(
                             child: Container(
                               width: 120,
                               child: Text(
                                 "${product.name}",
                                 style: TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.w500,
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Center(
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   Container(
                                     width: 100,
                                     child: Text(
                                       "\$${product.price}",
                                       style: TextStyle(
                                         fontSize: 12,
                                         fontWeight: FontWeight.w500,
                                         color: Colors.red,
                                       ),
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(3.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 RatingBar.builder(
                                   initialRating: 4,
                                   minRating: 1,
                                   direction: Axis.horizontal,
                                   allowHalfRating: true,
                                   itemCount: 5,
                                   itemPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
                                   itemBuilder: (context, _) => Icon(
                                     Icons.star,
                                     color: Colors.amber,
                                   ),
                                   onRatingUpdate: (rating) {
                                     // You can use this callback to handle rating updates
                                   },
                                   itemSize: 14.0,
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(2.0),
                                   child: Container(
                                     child: Text(
                                       "(13)",
                                       style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                        ),
                      )
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
