
import 'package:flutter/material.dart';
import 'package:markazapp/Constant/City.dart';
import 'package:markazapp/Constant/colors.dart';
import 'package:markazapp/Screens/ordersdetail_screen.dart';
import 'package:markazapp/Services/api_service.dart';
import 'package:markazapp/provider/listoforder_provider.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  APIService? apiService;

  int customerId = 0;

  @override
  void initState() {
    getCustomerId();
    Provider.of<listOfOrderProvider>(context, listen: false).getListOfOrder();
    apiService = APIService();
    super.initState();
  }

  Future<void> getCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    customerId = prefs.getInt('customerId')!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<listOfOrderProvider>(builder: (context, provider, __) {
      if (provider.listOfOrders.isNotEmpty) {
        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: Material(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        
                        title: Text("Markaz",style: TextStyle(color: Colors.black),),
                        
                        backgroundColor: Colors.white,
                        leading: GestureDetector(
                            onTap: () {}, child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.search,color: Colors.black,),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "My Order",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: context.width(),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.listOfOrders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              print("hello");
                              
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          order:provider.listOfOrders[index],
          orderId: provider.listOfOrders[index].id,
        ),
      ),
    );
  },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: secondaryColor3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(
  'Order ID: #${provider.listOfOrders[index].id}',
  style: TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 20,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${('items')} (${provider.listOfOrders[index].lineItems!.length})',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: textColors,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                       Text(
  'Total Amount: \$${provider.listOfOrders[index].total}',
  style: TextStyle(
    fontSize: 14,
    color: textColors,
    fontWeight: FontWeight.normal,
  ),
),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 20,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          provider
                                              .listOfOrders[index].dateCreated
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: textColors,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          provider.listOfOrders[index].status
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: Material(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    leading: GestureDetector(
                        onTap: () {}, child: Icon(Icons.arrow_back_ios)),
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: Text(
                        "My Order",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
