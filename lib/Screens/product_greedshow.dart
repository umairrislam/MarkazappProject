
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markazapp/Constant/colors.dart';

import 'package:markazapp/Models/product_model.dart';
import 'package:markazapp/Models/productvariations_model.dart';


import 'package:nb_utils/nb_utils.dart';

class ProductGreedShow extends StatefulWidget {
  const ProductGreedShow({
    Key? key,
    required this.discountPercentage,
    required this.isSingleView,
    
    required this.categoryId,
   required  this.latestModeldata,
    this.singleProductVariations,
  }) : super(key: key);
  final SingleProductVariations? singleProductVariations;
  final String discountPercentage;
  final bool isSingleView;
  final int categoryId;
  final ProductModel latestModeldata;


  @override
  State<ProductGreedShow> createState() => _ProductGreedShowState();
}

class _ProductGreedShowState extends State<ProductGreedShow> {
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;

  // @override
  // initState() {
  //   for (var element in wishList) {
  //     if (element.id == widget.productModel.id) {
  //       isFavorite = true;
  //     }
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: secondaryColor3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              widget.isSingleView
                  ? GestureDetector(
                      // onTap: () {
                      //   categoryDetailScreen(
                      //     productModel: widget.productModel,
                      //     //categoryId: widget.categoryId,
                      //   ).launch(context);
                      // },
                      child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               width: 100,
                               height: 85,
                               child: CachedNetworkImage(
                                 imageUrl: "${widget.latestModeldata.images?[0].src}",
                                 placeholder: (context, url) => CircularProgressIndicator(),
                                 errorWidget: (context, url, error) => Icon(Icons.error),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                    )
                  : GestureDetector(
                      // onTap: () {
                      //   categoryDetailScreen(
                      //     productModel: widget.productModel,
                      //    // categoryId: widget.categoryId,
                      //   ).launch(context);
                      // },
                      child:  Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               width: 100,
                               height: 85,
                               child: CachedNetworkImage(
                                 imageUrl: "${widget.latestModeldata.images?[0].src}",
                                 placeholder: (context, url) => CircularProgressIndicator(),
                                 errorWidget: (context, url, error) => Icon(Icons.error),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                    ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  // onTap: isFavorite
                  //     ? () {
                  //         ScaffoldMessenger.of(context)
                  //             .showSnackBar(const SnackBar(
                  //                 content: Text(
                  //           'Already added to the wishlist',
                  //           textAlign: TextAlign.center,
                  //         )));
                  //       }
                  //     : () async {
                  //         final Wishlist wishLists = Wishlist(
                  //           id: widget.productModel.id,
                  //           name: widget.productModel.name,
                  //           price: widget.singleProductVariations != null
                  //               ? widget.singleProductVariations!.salePrice
                  //                   .toInt()
                  //               : widget.productModel.salePrice.toInt(),
                  //           img: widget.productModel.images![0].src,
                  //           categoryId: widget.categoryId,
                  //         );
                  //         addToWishList(wishLists);
                  //         setState(() {
                  //           isFavorite = !isFavorite;
                  //         });
                  //         ScaffoldMessenger.of(context)
                  //             .showSnackBar(const SnackBar(
                  //                 content: Text(
                  //           'Added to the wishlist',
                  //           textAlign: TextAlign.center,
                  //         )));
                  //       },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: primaryColor.withOpacity(0.05),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: isFavorite
                        ? const Center(
                            child: Icon(
                              Icons.favorite,
                              color: secondaryColor1,
                            ),
                          )
                        : const Center(child: Icon(Icons.favorite_border)),
                  ).visible(false),
                ),
              ),
              widget.discountPercentage.toInt() != 202
                  ? Positioned(
                      left: 7,
                      top: 10,
                      child: Container(
                        height: 23,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: secondaryColor3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.discountPercentage.toDouble().round()} %',
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.latestModeldata.name.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: textColors,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                widget.singleProductVariations != null
                    ? Text(
                        widget.singleProductVariations!.salePrice.toInt() <= 0
                            ? '\$${widget.singleProductVariations!.regularPrice}'
                            : '\$${widget.singleProductVariations!.salePrice}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Text(
                        widget.latestModeldata.salePrice.toInt() <= 0
                            ? '\$${widget.latestModeldata.regularPrice}'
                            : '\$${widget.latestModeldata.salePrice}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      RatingBarWidget(
                        rating: initialRating,
                        activeColor: ratingColor,
                        inActiveColor: ratingColor,
                        size: 18,
                        onRatingChanged: (aRating) {
                          setState(() {
                            initialRating = aRating;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                        // onTap: () {
                        //   ProductDetailScreen(
                        //     productModel: widget.productModel,
                        //     categoryId: widget.categoryId,
                        //   ).launch(context);
                        // },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: const Center(
                              child: Icon(
                            Icons.shopping_bag,
                            color: primaryColor,
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
