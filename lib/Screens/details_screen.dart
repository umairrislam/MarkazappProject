import 'dart:convert';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markazapp/Constant/colors.dart';
import 'package:markazapp/Constant/spinkit.dart';
import 'package:markazapp/Models/addtocart_model.dart';
import 'package:markazapp/Models/product_model.dart';
import 'package:markazapp/Models/productvariations_model.dart';
import 'package:markazapp/Screens/cartscreen.dart';
import 'package:markazapp/Screens/colors.dart';
import 'package:markazapp/Screens/config.dart';
import 'package:markazapp/Screens/home_screen.dart';
import 'package:markazapp/Screens/product_greedshow.dart';
import 'package:markazapp/Services/api_service.dart';

import 'package:markazapp/provider/featured_provider.dart';
import 'package:markazapp/provider/product_variationsprovider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class detailProductScreen extends StatefulWidget {
  final ProductModel latestdetaildata;
  final SingleProductVariations? singleProductsVariation;
  final int categoryId;

  const detailProductScreen(
      {Key? key,
      required this.latestdetaildata,
      required this.categoryId,
      this.singleProductsVariation})
      : super(key: key);

  @override
  State<detailProductScreen> createState() => _detailProductScreenState();
}

class _detailProductScreenState extends State<detailProductScreen> {
  PageController pageController = PageController(initialPage: 1);
  bool isItPurchased = false;
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;
  bool alreadyInCart = false;

  String? selectedSize;
  Color? selectedColor;

  List<dynamic> sizeList = [];
  List<List<dynamic>> attributeList = [];
  List<dynamic> attributeNameList = [];
  List<dynamic> selectedAttributes = [];
  List<dynamic> list = [];
  List<dynamic> colorList = [];
  List<Color> finalColorList = [];
  int? finalProductVariationId;
  int simpleIntInput = 0;

  int attributesNumber = 0;
  String fistAttribute = '';

  int productQuantity = 1;
  int counter = 0;
  int counter2 = 0;

  double variationRegularPrice = 0;
  double variationSalePrice = 0;

  @override
  void initState() {
    checkId();
    apiService = APIService();

    super.initState();
    Provider.of<CartNotifier>(context, listen: false);
    simpleProductDiscount = discountGenerator(
        widget.latestdetaildata.regularPrice!, widget.latestdetaildata.salePrice!);
    Provider.of<FeaturedProvider>(context, listen: false)
        .getAllLatestfeaturelists();
    Provider.of<singleProductVariationProvider>(context, listen: false)
        .getSingleProductVariation(widget.latestdetaildata.id!.toInt());
  }

  late APIService apiService;
  int? simpleProductDiscount;
  int? customerId;
  Future<void> checkId() async {
    final prefs = await SharedPreferences.getInstance();
    customerId = prefs.getInt('customerId') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    counter++;
    counter2++;
  
    final size = MediaQuery.of(context).size;
    return widget.latestdetaildata.images!.isNotEmpty
        ? Consumer(builder: (context, ref, __) {
            return Scaffold(
              backgroundColor: Colors.white,
             bottomNavigationBar: Transform.translate(
  offset: Offset(0.0, -10),
  child: Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(100),
      ),
      child: BottomAppBar(
         color: Colors.blue.shade100,
        child: Container(
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<CartNotifier>(
                builder: (context, cartProvider, child) {
                  if (widget.latestdetaildata.type == 'simple') {
                    for (var element in cartProvider.cartItems) {
                      if (element.productId == widget.latestdetaildata.id) {
                        alreadyInCart = true;
                      }
                    }
                  } else {
                    for (var element in cartProvider.cartItems) {
                      if (element.variationId == finalProductVariationId) {
                        alreadyInCart = true;
                        break;
                      } else {
                        alreadyInCart = false;
                      }
                    }
                  }

                  return GestureDetector(
                    onTap: () {
                      if (alreadyInCart == false) {
                        cartProvider.addItemInfo(CartOtherInfo(
                          variationId: finalProductVariationId ?? 0,
                          productId: widget.latestdetaildata.id,
                          quantity: productQuantity,
                          type: widget.latestdetaildata.type,
                          productName: widget.latestdetaildata.name,
                          productImage: widget.latestdetaildata.images![0].src,
                          productPrice: widget.latestdetaildata.type != 'simple'
                              ? variationSalePrice <= 0
                                  ? variationRegularPrice
                                  : variationSalePrice
                              : widget.latestdetaildata.salePrice.toDouble() <= 0
                                  ? widget.latestdetaildata.regularPrice.toDouble()
                                  : widget.latestdetaildata.salePrice.toDouble(),
                          attributesName: widget.latestdetaildata.type != 'simple'
                              ? attributeNameList
                              : [],
                          selectedAttributes: widget.latestdetaildata.type != 'simple'
                              ? selectedAttributes
                              : [],
                        ));
                        CartScreen().launch(context);
                      } else {
                        CartScreen().launch(context);
                      }
                      // No need to setState for alreadyInCart here.
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
                            'Add to cart',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Consumer<CartNotifier>(
                builder: (context, cartProvider, child) {
                  if (widget.latestdetaildata.type == 'simple') {
                    for (var element in cartProvider.cartItems) {
                      if (element.productId == widget.latestdetaildata.id) {
                        alreadyInCart = true;
                      }
                    }
                  }
                

                  return GestureDetector(
                    onTap: () {
                      if (!alreadyInCart) {
                        cartProvider.addItemInfo(CartOtherInfo(
                          variationId: finalProductVariationId ?? 0,
                          productId: widget.latestdetaildata.id,
                          quantity: productQuantity,
                          type: widget.latestdetaildata.type,
                          productName: widget.latestdetaildata.name,
                          productImage: widget.latestdetaildata.images![0].src,
                          productPrice: widget.latestdetaildata.type != 'simple'
                              ? variationSalePrice <= 0
                                  ? variationRegularPrice
                                  : variationSalePrice
                              : widget.latestdetaildata.salePrice.toDouble() <= 0
                                  ? widget.latestdetaildata.regularPrice.toDouble()
                                  : widget.latestdetaildata.salePrice.toDouble(),
                          attributesName: widget.latestdetaildata.type != 'simple'
                              ? attributeNameList
                              : [],
                          selectedAttributes: widget.latestdetaildata.type != 'simple'
                              ? selectedAttributes
                              : [],
                        ));
                        CartScreen().launch(context);
                      } else {
                        CartScreen().launch(context);
                      }
                      
                    },
                    child: Container(
                      width: 130,
                      height: 45,
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 2,
                          color: Colors.green,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         
                          Text(
                            'Buy',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),

              body: SingleChildScrollView(
                  child: widget.latestdetaildata.type == 'simple'
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 1,
                              child: Consumer<FeaturedProvider>(
                                builder: (context, productProvider, child) {
                                  if (productProvider.isloading) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: CustomScrollView(
                                        slivers: <Widget>[
                                          SliverAppBar(
                                              automaticallyImplyLeading: false,
                                              expandedHeight:
                                                  size.height * 0.35,
                                              floating: false,
                                              pinned: true,
                                              flexibleSpace: Stack(
                                                fit: StackFit.loose,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             singleProductVariationConsumer(
                                                      //                 spvariation:
                                                      //                     productProvider
                                                      //                         .products
                                                      //                         .toString())

                                                      //                         ));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .vertical(
                                                                bottom: Radius
                                                                    .circular(
                                                                        20)),
                                                        image: DecorationImage(
                                                          image:
                                                              CachedNetworkImageProvider(
                                                            widget.latestdetaildata
                                                                .images![0].src
                                                                .toString(),
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                            spreadRadius: 0,
                                                            blurRadius: 20,
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 30,
                                                    left: 5,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .horizontal(
                                                                right: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              iconSize: 20,
                                                              icon: Icon(Icons
                                                                  .arrow_back_ios)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 30,
                                                    right: 5,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .horizontal(
                                                                left: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {},
                                                              iconSize: 20,
                                                              icon: Icon(Icons
                                                                  .shopping_cart)),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SliverList(
                                              delegate:
                                                  SliverChildListDelegate([
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Text(
                                                      widget.latestdetaildata.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  simpleProductDiscount !=
                                                              202 ||
                                                          widget
                                                              .latestdetaildata
                                                              .salePrice!
                                                              .isNotEmpty
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              widget.latestdetaildata
                                                                          .type !=
                                                                      'simple'
                                                                  ? '$currencySign${widget.latestdetaildata.salePrice}'
                                                                  : '$currencySign${widget.latestdetaildata.salePrice}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red
                                                                      .shade600,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              '$currencySign${widget.latestdetaildata.regularPrice}',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color:
                                                                    textColors,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Container(
                                                              height: 30,
                                                              width: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color:
                                                                        secondaryColor3),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '$simpleProductDiscount %',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                        secondaryColor1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 15),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              '$currencySign${widget.latestdetaildata.regularPrice} ',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 110,
                                              child: Center(
                                                child: Text(
                                                  "Quantity",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: 110,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        productQuantity > 1
                                                            ? productQuantity--
                                                            : productQuantity =
                                                                1;
                                                      });
                                                    },
                                                    child: Material(
                                                      elevation: 4,
                                                      color: secondaryColor3,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: const SizedBox(
                                                        width: 33,
                                                        height: 33,
                                                        child: Center(
                                                          child: Icon(
                                                              Icons.remove,
                                                              size: 25,
                                                              color:
                                                                  textColors),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    productQuantity.toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        productQuantity++;
                                                      });
                                                    },
                                                    child: Material(
                                                      elevation: 4,
                                                      color: secondaryColor3,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: const SizedBox(
                                                        width: 33,
                                                        height: 33,
                                                        child: Center(
                                                          child: Icon(Icons.add,
                                                              size: 25,
                                                              color:
                                                                  textColors),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
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
                                   itemSize: 18.0,
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(2.0),
                                   child: Container(
                                     child: Text(
                                       "(13)",
                                       style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                                     ),
                                   ),
                                 ),]
                                            ),),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 30),
                                              child: Html(
                                                data:
                                                    "${widget.latestdetaildata.description}",
                                              ),
                                            ),
                                           
                                            Text(
                                              "Delivery & Services",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30)),
                                                          color: secondaryColor1
                                                              .withOpacity(.20),
                                                        ),
                                                        child: const Center(
                                                            child: Icon(
                                                          Icons.car_crash,
                                                          size: 18,
                                                        )),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        "Free Delivery",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30)),
                                                          color: secondaryColor1
                                                              .withOpacity(.20),
                                                        ),
                                                        child: const Center(
                                                            child: Icon(
                                                          Icons.atm,
                                                          size: 18,
                                                        )),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        "Pay on delivery available",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30)),
                                                          color: secondaryColor1
                                                              .withOpacity(.20),
                                                        ),
                                                        child: const Center(
                                                            child: Icon(
                                                          Icons.repeat,
                                                          size: 18,
                                                        )),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      SizedBox(
                                                        width: context.width() /
                                                            1.4,
                                                        child: Text(
                                                          "Easy 30 days return & exchange available",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.black,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    "Related Products",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                               ],
                                            ),
                                          ]))
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(child: spinkit),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      : Consumer<singleProductVariationProvider>(
                          builder: (context, variation, child) {
                            if (!variation.isloading) {
                              if (counter <= 1) {
                                for (int i = 0;
                                    i <
                                        variation.productVariation[0]
                                            .attributes!.length;
                                    i++) {
                                  List<String> demoList = [];
                                  for (var element
                                      in variation.productVariation) {
                                    demoList.add(element.attributes![i].option
                                        .toString());
                                  }
                                  demoList = demoList.toSet().toList();
                                  attributeList.add(demoList);
                                }

                                for (var element in variation
                                    .productVariation[0].attributes!) {
                                  attributeNameList.add(element.name);
                                  selectedAttributes.add('null');
                                }

                                for (int i = 0;
                                    i < selectedAttributes.length;
                                    i++) {
                                  selectedAttributes[i] = attributeList[i][0];
                                }
                                attributeList = attributeList.toSet().toList();
                              }
                              if (counter2 <= 1) {
                                getSingleProductVariations(
                                  productID: widget.latestdetaildata.id!.toInt(),
                                  selectedAttributes: selectedAttributes,
                                );
                              }

                              ///___________WishList Logic_____________________________________________
                              int discount = 0;
                              if (variationRegularPrice != 0 ||
                                  variationSalePrice != 0) {
                                discount = discountGenerator(
                                  variationRegularPrice.toString(),
                                  variationSalePrice.toString(),
                                );
                              }

                              return Column(
                                children: [
                                  ///_____________Photo & Buttons_________________________
                                  Stack(
                                    children: [
                                      ///_______Photos____________
                                      CarouselSlider.builder(
                                        itemCount:
                                            widget.latestdetaildata.images!.length,
                                        options: CarouselOptions(
                                          autoPlay: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 5),
                                          height: 300,
                                          aspectRatio: 1,
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          reverse: false,
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 800),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                          onPageChanged: null,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                        itemBuilder: (BuildContext context,
                                                int itemIndex,
                                                int pageViewIndex) =>
                                            Container(
                                          color: secondaryColor3,
                                          width: double.infinity,
                                          child:CachedNetworkImage(
                                 imageUrl: "${widget.latestdetaildata.images?[0].src}",
                                 placeholder: (context, url) => CircularProgressIndicator(),
                                 errorWidget: (context, url, error) => Icon(Icons.error),
                                 fit: BoxFit.cover,
                               ),
                                        ),
                                      ),

                                      ///_________Favorite & Share Button_________________________________________________________
                                      Positioned(
                                        right: 20,
                                        top: 20,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isFavorite = !isFavorite;
                                                });
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: primaryColor
                                                        .withOpacity(0.05),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(30),
                                                  ),
                                                ),
                                                child: isFavorite
                                                    ? const Center(
                                                        child: Icon(
                                                          Icons.favorite,
                                                          color:
                                                              secondaryColor1,
                                                        ),
                                                      )
                                                    : const Center(
                                                        child: Icon(
                                                        Icons.favorite_border,
                                                        color: secondaryColor1,
                                                      )),
                                              ).visible(false),
                                            ),
                                            const SizedBox(height: 15),
                                            GestureDetector(
                                              onTap: () {
                                                Share.share(
                                                    '${widget.latestdetaildata.name}. Buy Now at: https://www.indikeon.com/?p=${widget.latestdetaildata.id}');
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: primaryColor
                                                        .withOpacity(0.05),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(30),
                                                  ),
                                                ),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.share,
                                                  color: secondaryColor1,
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///__________BackButton__________________________________________________
                                      Positioned(
                                        left: 10,
                                        top: 20,
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.arrow_back),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                        bottom: 20,
                                        right: 20),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.latestdetaildata.name.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),

                                        variationSalePrice > 0
                                            ? Row(
                                                children: [
                                                  Text(
                                                    widget.latestdetaildata.type !=
                                                            'simple'
                                                        ? '$currencySign$variationSalePrice '
                                                        : '$currencySign${widget.latestdetaildata.salePrice}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    '$currencySign$variationRegularPrice ',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: textColors,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 30,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              secondaryColor3),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '$discount %',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              secondaryColor1,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Text(
                                                    '$currencySign$variationRegularPrice ',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                        SizedBox(
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: attributeList.length,
                                            itemBuilder: (context, i) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Select ${attributeNameList[i]}',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 55,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        attributeList[i].length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          counter2 = 0;
                                                          selectedAttributes[
                                                                  i] =
                                                              attributeList[i]
                                                                  [index];
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        100)),
                                                            color: selectedAttributes[
                                                                        i] ==
                                                                    attributeList[
                                                                            i]
                                                                        [index]
                                                                ? secondaryColor1
                                                                : Colors.grey
                                                                    .shade300,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child: Text(
                                                                attributeList[i]
                                                                    [index],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  color: selectedAttributes[
                                                                              i] ==
                                                                          attributeList[i]
                                                                              [
                                                                              index]
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        ///__________Select Color Buttons & Quantity button______________________________
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                "Quantity",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: 110,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    productQuantity > 1
                                                        ? productQuantity--
                                                        : productQuantity = 1;
                                                  });
                                                },
                                                child: Material(
                                                  elevation: 4,
                                                  color: secondaryColor3,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: const SizedBox(
                                                    width: 33,
                                                    height: 33,
                                                    child: Center(
                                                      child: Icon(Icons.remove,
                                                          size: 25,
                                                          color: textColors),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(productQuantity.toString(),
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    productQuantity++;
                                                  });
                                                },
                                                child: Material(
                                                  elevation: 4,
                                                  color: secondaryColor3,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: const SizedBox(
                                                    width: 33,
                                                    height: 33,
                                                    child: Center(
                                                      child: Icon(Icons.add,
                                                          size: 25,
                                                          color: textColors),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        ///_____________Delivery & Services__________________________

                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Delivery & Services",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  30)),
                                                      color: secondaryColor1
                                                          .withOpacity(.20),
                                                    ),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.delivery_dining,
                                                      size: 18,
                                                    )),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Free Delivery",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  30)),
                                                      color: secondaryColor1
                                                          .withOpacity(.20),
                                                    ),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.payment,
                                                      size: 18,
                                                    )),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Pay on delivery available",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  30)),
                                                      color: secondaryColor1
                                                          .withOpacity(.20),
                                                    ),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.repeat,
                                                      size: 18,
                                                    )),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  SizedBox(
                                                    width:
                                                        context.width() / 1.4,
                                                    child: Text(
                                                      "Easy 30 days return & exchange available",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),

                                        ///__________________Related Products____________________________
                                        const SizedBox(height: 15),
                                        Consumer<FeaturedProvider>(
                                            builder:
                                                (context, featured, child) {
                                          return HorizontalList(
                                              itemCount:
                                                  featured.features.length,
                                              itemBuilder: (_, index) {
                                                final productVariation = Provider
                                                        .of<singleProductVariationProvider>(
                                                            context,
                                                            listen: false)
                                                    .getSingleProductVariation(
                                                        widget.latestdetaildata.id!
                                                            .toInt());
                                                return widget.latestdetaildata.id !=
                                                        widget
                                                            .singleProductsVariation
                                                            ?.id
                                                    ? Consumer<
                                                            singleProductVariationProvider>(
                                                        builder: (context,
                                                            provider, child) {
                                                        if (featured
                                                                .features[index]
                                                                .type !=
                                                            'simple') {
                                                          int discount = discountGenerator(
                                                              provider
                                                                  .productVariation[
                                                                      0]
                                                                  .regularPrice
                                                                  .toString(),
                                                              provider
                                                                  .productVariation[
                                                                      0]
                                                                  .salePrice
                                                                  .toString());
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 15),
                                                            child:
                                                                ProductGreedShow(
                                                              singleProductVariations:
                                                                  provider
                                                                      .productVariation[0],
                                                              latestModeldata:
                                                                  featured.features[
                                                                      index],
                                                              discountPercentage:
                                                                  discount
                                                                      .toString(),
                                                              isSingleView:
                                                                  false,
                                                              categoryId: widget
                                                                  .categoryId,
                                                            ),
                                                          );
                                                        } else {
                                                          int discount =
                                                              discountGenerator(
                                                                  featured
                                                                      .features[
                                                                          index]
                                                                      .regularPrice
                                                                      .toString(),
                                                                  featured
                                                                      .features[
                                                                          index]
                                                                      .salePrice
                                                                      .toString());
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 15),
                                                            child:
                                                                ProductGreedShow(
                                                              latestModeldata:
                                                                  featured.features[
                                                                      index],
                                                              discountPercentage:
                                                                  discount
                                                                      .toString(),
                                                              isSingleView:
                                                                  false,
                                                              categoryId: widget
                                                                  .categoryId,
                                                            ),
                                                          );
                                                        }
                                                      })
                                                    : Container();
                                              });
                                        })
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                          },
                        )),
            );
          })
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => HomeScreen())));
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Container(
              child: Center(
                child: Text("Data not found"),
              ),
            ),
          );
  }

  int discountGenerator(String regularPrice, String sellingPrice) {
    double discount;

    if (regularPrice.isEmpty || sellingPrice.isEmpty) {
      return 202;
    } else {
      discount =
          ((double.parse(sellingPrice) * 100) / double.parse(regularPrice)) -
              100;
    }

    return discount.toInt();
  }

  void getSingleProductVariations(
      {required int productID,
      required List<dynamic> selectedAttributes}) async {
    EasyLoading.show(status: 'loading');
    List<SingleProductVariations> productVariation = [];

    String url =
        '${Config.url}products/$productID/variations?consumer_key=${Config.key}&consumer_secret=${Config.secret}&per_page=50';
    var response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        productVariation.add(SingleProductVariations.fromJson(i));
      }

      for (var element in productVariation) {
        int numberOfTrue = 0;

        for (int j = 0; j < element.attributes!.length; j++) {
          if (element.attributes![j].option == selectedAttributes[j]) {
            numberOfTrue++;
          }
        }
        if (numberOfTrue == selectedAttributes.length) {
          setState(() {
            variationSalePrice = element.salePrice.toDouble();
            variationRegularPrice = element.regularPrice.toDouble();
            finalProductVariationId = element.id!.toInt();
          });
        }
        EasyLoading.dismiss();
      }
    }
  }
}
