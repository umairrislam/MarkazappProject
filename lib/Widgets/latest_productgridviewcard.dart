import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:markazapp/Models/product_model.dart';
import 'package:markazapp/Models/productvariations_model.dart';
import 'package:markazapp/Screens/details_screen.dart';

class LatestProductGridViewCard extends StatefulWidget {
  final ProductModel gdata;
   
  final SingleProductVariations? variation;

  const LatestProductGridViewCard({super.key,required this.gdata,this.variation});

  @override
  State<LatestProductGridViewCard> createState() => _LatestProductGridViewCardState();
}

class _LatestProductGridViewCardState extends State<LatestProductGridViewCard> {
  @override
  Widget build(BuildContext context) {
     double prices = double.tryParse(widget.gdata.price!) ?? 0.0;
    double discount = 0.0;

    // Calculate discount based on conditions
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
    return Scaffold(
      body: GestureDetector(
         onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>detailProductScreen(latestdetaildata: widget.gdata,categoryId: widget.gdata.id!.toInt(),),
                        ),
                      );
                    },
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                  
          widget.gdata.price!.isNotEmpty
          ? Container(
              width: 100,
              height: 90,
              child: CachedNetworkImage(
                imageUrl: "${widget.gdata.images?[0].src}",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            )
          : Container(
              width: 135,
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
                                "${widget.gdata.name}",
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
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                         
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                 
                                  child: Text(
                                   widget.gdata.price!.isNotEmpty?"\$${ widget.gdata.price.toString()}":"",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2,),
                             
                              widget.gdata.price!.isNotEmpty
                                  ? Container(
                                    
                                    padding: EdgeInsets.all(2),
                                    
                                    child: Text(
                                    "\$ ${widget.gdata.price!}",
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
                        Row(
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
                                child: 
                            
                                Text(
                                  "(15)",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  widget.gdata.price!.isNotEmpty
                      ? Positioned(
                          left: 120,
                          top: 20,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}