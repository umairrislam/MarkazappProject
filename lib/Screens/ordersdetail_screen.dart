// ignore_for_file: unused_result


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:markazapp/Constant/colors.dart';

import 'package:markazapp/Models/listoforder_model.dart';
import 'package:markazapp/Screens/check_outscreeen.dart';

import 'package:markazapp/Screens/navigationBarscreen.dart';
import 'package:markazapp/buttons/buttons.dart';
import 'package:markazapp/provider/update_provider.dart';
import 'package:provider/provider.dart';

import 'package:nb_utils/nb_utils.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen(
      {Key? key, required this.order, required this.orderId})
      : super(key: key);
  final ListOfOrders order;

  final int orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? reason;
  int orderStatus = 0;

  @override
  void initState() {
    super.initState();
    if (widget.order.status == 'pending') {
      orderStatus = 1;
    } else if (widget.order.status == 'processing') {
      orderStatus = 2;
    } else if (widget.order.status == 'completed') {
      orderStatus = 3;
    } else if (widget.order.status == 'delivered') {
      orderStatus = 4;
    } else if (widget.order.status == 'cancelled') {
      orderStatus = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProvider>(builder: (context, provider, __) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
           'Order Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
          ),
        ),
        body:SingleChildScrollView(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 70,
        width: 350,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 1; i <= 4; i++)
                      SizedBox(
                        child: Icon(
                          orderStatus >= i
                              ? Icons.check_circle
                              : Icons.radio_button_off_sharp,
                          size: 30,
                          color: secondaryColor1,
                        ),
                      ),
                    Container(
                      height: 2,
                      width: 70,
                      decoration: const BoxDecoration(
                        color: secondaryColor1,
                      ),
                    ),
                    orderStatus == 5
                        ? SizedBox(
                            child: Icon(
                              Icons.check_circle,
                              size: 30,
                              color: secondaryColor1,
                            ),
                          )
                        : SizedBox(
                            child: Icon(
                              Icons.radio_button_off_sharp,
                              size: 30,
                              color: secondaryColor1,
                            ),
                          ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Pending'),
                  Text('Processing'),
                  Text('Completed'),
                  Text('Delivered'),
                ],
              ),
            ],
          ),
        ),
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: #${widget.order.id.toString()}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  widget.order.dateCreated.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: textColors,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Items: ${widget.order.lineItems!.length}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.order.lineItems!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          width: 1,
                          color: secondaryColor3,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 20,
                              left: 20,
                              bottom: 5,
                            ),
                            child: Text(
                              widget.order.lineItems![index].name.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                                top: 8,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Price: \$${widget.order.lineItems![index].total}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'Quantity: ${widget.order.lineItems![index].quantity}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Order',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColors,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '\$${widget.order.total.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: textColors,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '\$${widget.order.total}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.order.paymentMethodTitle.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: textColors,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: secondaryColor3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Shipping Address',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    '${widget.order.shipping!.address1}, ${widget.order.shipping!.address2}, ${widget.order.shipping!.city}, ${widget.order.shipping!.state}, ${widget.order.shipping!.postcode}, ${widget.order.shipping!.country}, Phone: ${widget.order.shipping!.phone}.',
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: secondaryColor3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ],
  ),
),

        bottomNavigationBar: Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      Expanded(
        child: widget.order.status == 'pending'
            ? Button1(
                buttonText: 'Pay Now',
                buttonColor: primaryColor,
                onPressFunction: () {
                  MyWebView(
                    url: widget.order.paymentUrl,
                    id: widget.order.id.toString(),
                  ).launch(context);
                },
              )
            : Button1(
                buttonText: 'Go to Home',
                buttonColor: primaryColor,
                onPressFunction: () {
                  NavigationBarScreen().launch(context, isNewTask: true);
                },
              ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: ButtonType2(
          buttonText: 'Cancel Order',
          buttonColor: primaryColor,
          onPressFunction: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Canceling Order',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColors,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.cancel_outlined),
                              )
                            ],
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter reason for cancel order',
                          ),
                          maxLines: 3,
                          onChanged: (value) {
                            reason = value;
                          },
                        ),
                        const SizedBox(height: 30),
                        Button1(
                          buttonText: 'Cancel Order',
                          buttonColor: primaryColor,
                          onPressFunction: () {
                            EasyLoading.show(status: 'Canceling order....');
                            provider
                                .updateOrder(
                                  widget.orderId!.toInt(),
                                  reason.toString(),
                                )
                                .then((value) {
                              if (value) {
                                provider.orders;
                                EasyLoading.showSuccess('Successful');
                                /*const MyOrderScreen().launch(
                                  context,
                                  isNewTask: true,
                                );*/
                              } else {
                                EasyLoading.showError('Failed with Error');
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ).visible(orderStatus < 3),
    ],
  ),
),

      );
    });
  }
}
