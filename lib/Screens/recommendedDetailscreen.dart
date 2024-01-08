import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:markazapp/itemsmodel.dart';
import 'package:markazapp/Screens/recommendedPlaceorderscreen.dart';


class RecommendedDetailScreen extends StatefulWidget {
  final Items remommendeddetails;
  const RecommendedDetailScreen({super.key,required this.remommendeddetails});

  @override
  State<RecommendedDetailScreen> createState() => _RecommendedDetailScreenState();
}

class _RecommendedDetailScreenState extends State<RecommendedDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markaz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset(
                  "${widget.remommendeddetails.images}",
                  width: MediaQuery.of(context).size.width * 1,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            "${widget.remommendeddetails.productCode}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "${widget.remommendeddetails.text}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(
                            "${widget.remommendeddetails.favtext}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemSize: 20.0,
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("${widget.remommendeddetails.ratingstar}"),
                  ),
                  Text("${widget.remommendeddetails.rating}"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Size:"),
                    SizedBox(width: 4,),
                    Container(
                      width: 100,
                      height: 29,
                      // Adjust padding as needed
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${widget.remommendeddetails.productSize}",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
                Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(child: Text("Rs ${widget.remommendeddetails.rupees}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                              ),
                              if(widget.remommendeddetails.discount==true)
                          Container(
                            width: MediaQuery.of(context).size.width*0.1,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                                                   TextSpan(text:"${widget.remommendeddetails.DiscountPrice}",style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.white, fontSize: 13) ),
                                                        
                                    ]
                                  ),
                                ),
                              ),
                            ),
                          ),
                            ],
                          ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Details",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${widget.remommendeddetails.recommendedetails}"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                 onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RecommendedPlacrorderScreen(recommendedplaceorderdata: widget.remommendeddetails,)));
      },
                child: Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             Container(
               width: 130,
                height: 45,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.black, // Set the border color to black
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.share,
        color: Colors.black,
      ),
      SizedBox(width: 8),
      Text(
        'Share',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ],
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}