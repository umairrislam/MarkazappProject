import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:markazapp/Models/addtocart_model.dart';
import 'package:markazapp/Models/product_model.dart';
import 'package:markazapp/Screens/cartscreen.dart';
import 'package:markazapp/Services/api_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final ProductModel detaildata;

  const PostDetailScreen({Key? key, required this.detaildata}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat.yMMMd().format(dateTime);
  }

  int? simpleProductDiscount;
  late APIService apiService;
  bool alreadyInCart = false;
  int productQuantity = 1;
  double variationSalePrice = 0.0;
  double variationRegularPrice = 0.0;
  List<String> attributeNameList = [];
  List<String> selectedAttributes = [];

  int? finalProductVariationId;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
    Provider.of<CartNotifier>(context, listen: false);
    simpleProductDiscount = discountGenerator(
      widget.detaildata.regularPrice!,
      widget.detaildata.salePrice!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
            floating: false,
            pinned: false,
            automaticallyImplyLeading: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: "${widget.detaildata.images?[0].src}",
                placeholder: (context, url) => CircularProgressIndicator(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " ${widget.detaildata.name}",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "\$${widget.detaildata.price}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Date: ${formatDate(widget.detaildata.date_created!)}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: MediaQuery.sizeOf(context).height*0.99,
                              child: Html(data: "${widget.detaildata.description}"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<CartNotifier>(builder: (context, cartProvider, child) {
                if (widget.detaildata.type == 'simple') {
                  for (var element in cartProvider.cartItems) {
                    if (element.productId == widget.detaildata.id) {
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
                        productId: widget.detaildata.id,
                        quantity: productQuantity,
                        type: widget.detaildata.type,
                        productName: widget.detaildata.name,
                        productImage: widget.detaildata.images![0].src,
                        productPrice: widget.detaildata.type != 'simple'
                            ? variationSalePrice <= 0
                                ? variationRegularPrice
                                : variationSalePrice
                            : widget.detaildata.salePrice.toDouble() <= 0
                                ? widget.detaildata.regularPrice.toDouble()
                                : widget.detaildata.salePrice.toDouble(),
                        attributesName: widget.detaildata.type != 'simple'
                            ? attributeNameList
                            : [],
                        selectedAttributes: widget.detaildata.type != 'simple'
                            ? selectedAttributes
                            : [],
                      ));
                      CartScreen().launch(context);
                    } else {
                      CartScreen().launch(context);
                    }
                    setState(() {
                      alreadyInCart;
                    });
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
              }),
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

  int discountGenerator(String regularPrice, String sellingPrice) {
    double discount;

    if (regularPrice.isEmpty || sellingPrice.isEmpty) {
      return 202;
    } else {
      discount = ((double.parse(sellingPrice) * 100) / double.parse(regularPrice)) - 100;
    }

    return discount.toInt();
  }
}
