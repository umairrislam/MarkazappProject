import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import 'package:markazapp/Models/product_model.dart';

class FeaturedGridViewCard extends StatefulWidget {
  final ProductModel fddata;
  const FeaturedGridViewCard({super.key,required this.fddata});

  @override
  State<FeaturedGridViewCard> createState() => _FeaturedGridViewCardState();
}

class _FeaturedGridViewCardState extends State<FeaturedGridViewCard> {
    
  @override
  Widget build(BuildContext context) {
    double prices = double.tryParse(widget.fddata.price!) ?? 0.0;
    double discount = 0.0;
     if (prices > 100) {
      discount = (prices * 15 / 100);
    } else if (prices > 300) {
      discount = (prices * 4 / 100);
    } else if (prices > 500) {
      discount = (prices * 5 / 100);
    } else if (prices > 700) {
      discount = (prices * 6 / 100);
    } else if (prices > 900) {
      discount = (prices * 7 / 100);
    } else {
      discount = (prices * 10 / 100);
    }

    double discountedPrice = prices - discount;
    return Scaffold(body:Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   widget.fddata.price!.isNotEmpty
                    ? Container(
              width: 100,
              height: 90,
              child: CachedNetworkImage(
                imageUrl: "${widget.fddata.images?[0].src}",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
                      )
                    : Container(
              width: 130,
              height: 90,
              child: CachedNetworkImage(
                imageUrl: "https://www.shutterstock.com/image-photo/sport-car-tuning-equipment-accessories-600nw-2221101627.jpg",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
                      ),
                        Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 150,
                          child: Center(
                            child: Text(
                              "${widget.fddata.name}",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 4,),
                        Container(
                          
                          child: Center(
                              child: Text( widget.fddata.price!.isNotEmpty?"\$${ widget.fddata.price.toString()}":"",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.red,
                                      fontSize: 12, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis)),
                        ),
                         SizedBox(width: 2,),
                         widget.fddata.price!.isNotEmpty
                                ? Container(
                                 
                                  padding: EdgeInsets.all(2),
                                  
                                  child: Text(
                                  "\$ ${widget.fddata.price!}",
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                )
                                : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
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
                            "(15)",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                      ),
            ),
           widget.fddata.price!.isNotEmpty
                    ? Positioned(
                        left: 120,
                        top: 15,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green, // Set the desired color
                          ),
                          child: Text(
                            discountedPrice.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Container(),
          ],)
        ),
      ),
    )
    );
  }
}