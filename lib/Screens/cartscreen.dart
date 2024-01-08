import 'package:flutter/material.dart';
import 'package:markazapp/Models/addtocart_model.dart';
import 'package:markazapp/Screens/auth_screen.dart';
import 'package:markazapp/Screens/check_outscreeen.dart';
import 'package:markazapp/Services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  APIService? apiService;
  int initialValue = 1;
   bool isCouponApply = false;

  @override
  void initState() {
    apiService = APIService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
          backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text("Markaz",style: TextStyle(color: Colors.black),),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView.builder(
            itemCount: cartNotifier.cartOtherInfoList.length,
            itemBuilder: (context, index) {
              CartOtherInfo cartItem = cartNotifier.cartOtherInfoList[index];

              return Card(
                elevation: 1,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 120,
                             decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors
                                .grey, 
                            width: 1, 
                          ),
                          borderRadius:
                              BorderRadius.circular(2.0), 
                        ),
                            child: Image.network(
                              cartItem.productImage ?? '',
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 160,
                                  child: Text(
                                    cartItem.productName ?? '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cartNotifier.decreaseQuantity(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text('${cartItem.quantity}'),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        cartNotifier.increaseQuantity(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '\$${cartItem.productPrice}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                 Padding(
                                   padding: const EdgeInsets.all(2.0),
                                   child: Row(children: [
                                     Text("Delete order"),
                                     SizedBox(width: 5,),
                                                           GestureDetector(
                                                               onTap: () {
                                    cartNotifier.removeItemInfo(cartItem.productName!);
                                                               },
                                                               child: Container(
                                                                 decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5.0),),
                                                                 child: Icon(
                                                                                                 Icons.delete,
                                                                                                 color: Colors.red,
                                                                 ),
                                                               ),
                                                             ),
                                   ],),
                                 )
                              ],
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
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartProvider, child) {
          return BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Container(
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                   
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        'Your Order',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 130,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Total Amount:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                 width: MediaQuery.of(context).size.width * 0.11,
                                child: Text(
                                   '\$${cartProvider.cartTotalPriceF(initialValue)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                  maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    'Subtotal:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.11,
                                    child: Text(
                                     '\$${cartProvider.cartTotalPriceF(initialValue)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                       maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final int? customerId = prefs.getInt('customerId');
                if (customerId == null) {
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                  );
                } else {
                  if (!mounted) return;
                  isCouponApply
                                      ? // Corrected the navigation logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutScreen(
                        couponPrice: cartProvider.promoPrice,
                      ),
                    ),
                  ): Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CheckOutScreen(),
                                          ),
                                        );
                }
              },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 8),
                        Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
        },
      ),
    );
  }
}
