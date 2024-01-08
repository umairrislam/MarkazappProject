import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:markazapp/Constant/City.dart';
import 'package:markazapp/Constant/colors.dart';
import 'package:markazapp/Models/addtocart_model.dart';
import 'package:markazapp/Models/ordercreate_model.dart'as lee;
import 'package:markazapp/Screens/navigationBarscreen.dart';
import 'package:markazapp/buttons/buttons.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:markazapp/Models/retrive_customermodel.dart';
import 'package:markazapp/Screens/addnewaddresstwo.dart';
import 'package:markazapp/Screens/checkout_shimmerwidget.dart';
import 'package:markazapp/Screens/config.dart';
import 'package:markazapp/Screens/confirmation_screen.dart';

import 'package:markazapp/Screens/paytm_config.dart';
import 'package:markazapp/Screens/usepaypalscreen.dart';
import 'package:markazapp/Services/api_service.dart';
import 'package:markazapp/provider/checkout_provider.dart';
import 'package:markazapp/provider/listoforder_provider.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class CheckOutScreen extends StatefulWidget {
  final double? couponPrice;
  const CheckOutScreen({super.key, this.couponPrice});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<lee.LineItemss> lineItems = <lee.LineItemss>[];
  RetrieveCustomer? retrieveCustomer;
  double totalAmount = 0;
  APIService? apiService;
  int initialValue = 1;
  bool isSuccess = false;
  // final plugin = PaystackPlugin();

  String whichPaymentIsChecked = 'Cash on Delivery';
  @override
  void initState() {
    apiService = APIService();
    // plugin.initialize(publicKey: paystackPublicId);
    Provider.of<checkOutProvider>(context, listen: false).getCustomerDetails();
    Provider.of<listOfOrderProvider>(context, listen: false).getListOfOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
           'Check Out',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        body: Stack(children: [
          FutureBuilder<RetrieveCustomer>(
              future: Provider.of<checkOutProvider>(context, listen: false)
                  .getCustomerDetails(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.data!.shipping!.address1!.isEmpty ||
                      snapShot.data!.shipping!.firstName!.isEmpty ||
                      snapShot.data!.shipping!.city!.isEmpty ||
                      snapShot.data!.billing!.phone!.isEmpty) {
                    Center(
                      child: Button1(
                          buttonText:
                              'Please add shipping Address First',
                          buttonColor: primaryColor,
                          onPressFunction: () => AddNewAddressTwo(
                                  initShipping: snapShot.data!.shipping,
                                  initBilling: snapShot.data!.billing)
                              .launch(context)),
                    );
                  }
                  retrieveCustomer = snapShot.data;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<CartNotifier>(
                                    builder: (context, provider, child) {
                                  lineItems = provider.cartItems;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${"Total Items:"} ${provider.cartOtherInfoList.length}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 130,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                right: 8,
                                                bottom: 8,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: secondaryColor3,
                                                    )),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        height: 110,
                                                        width: 110,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color:
                                                                secondaryColor3,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                          color:
                                                              secondaryColor3,
                                                          image: DecorationImage(
                                                              image: NetworkImage(provider
                                                                  .cartOtherInfoList[
                                                                      index]
                                                                  .productImage
                                                                  .toString())),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            provider
                                                                .cartOtherInfoList[
                                                                    index]
                                                                .productName
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              context.width() /
                                                                  2.3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  '${provider.cartOtherInfoList[index].productPrice}\$',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                ),

                                                                ///_____________________quantity_____________________
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                     'Quantity:',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color:
                                                                            textColors,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      provider
                                                                          .cartOtherInfoList[
                                                                              index]
                                                                          .quantity
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color:
                                                                            textColors,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount:
                                              provider.cartOtherInfoList.length,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                const SizedBox(height: 10),
                                Text(
                                  'Shipping Address',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: secondaryColor3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${snapShot.data!.shipping!.firstName} ${snapShot.data!.shipping!.lastName}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              AddNewAddressTwo(
                                                initShipping:
                                                    snapShot.data!.shipping,
                                                initBilling:
                                                    snapShot.data!.billing,
                                              ).launch(context);
                                            },
                                            child: Text(
                                             'Change',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: secondaryColor1,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${snapShot.data!.shipping!.address1}, ${snapShot.data!.shipping!.address2}, ${snapShot.data!.shipping!.city}, ${snapShot.data!.shipping!.state}, ${snapShot.data!.shipping!.postcode}, ${snapShot.data!.shipping!.country}, ${snapShot.data!.billing!.phone}',
                                          maxLines: 3,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                 'Payment Method',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(usePaypal),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              whichPaymentIsChecked == 'Paypal'
                                                  ? primaryColor
                                                  : secondaryColor3
                                                      .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value: whichPaymentIsChecked == 'Paypal',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked = 'Paypal'
                                            : whichPaymentIsChecked =
                                                'Cash on Delivery';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Paypal',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                     "https://assets.stickpng.com/images/580b57fcd9996e24bc43c530.png",
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(usePaypal),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(useStripe),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              whichPaymentIsChecked == 'Stripe'
                                                  ? primaryColor
                                                  : secondaryColor3
                                                      .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value: whichPaymentIsChecked == 'Stripe',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked = 'Stripe'
                                            : whichPaymentIsChecked =
                                                'Cash on Delivery';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Stripe',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Stripe_Logo%2C_revised_2016.svg/2560px-Stripe_Logo%2C_revised_2016.svg.png',
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(useStripe),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(usePaytm),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              whichPaymentIsChecked == 'Paytm'
                                                  ? primaryColor
                                                  : secondaryColor3
                                                      .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value: whichPaymentIsChecked == 'Paytm',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked = 'Paytm'
                                            : whichPaymentIsChecked =
                                                'Cash on Delivery';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Paytm',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                      'https://download.logo.wine/logo/Paytm/Paytm-Logo.wine.png',
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(usePaytm),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(useRazorpay),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: whichPaymentIsChecked ==
                                                  'Razorpay'
                                              ? primaryColor
                                              : secondaryColor3
                                                  .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value: whichPaymentIsChecked == 'Razorpay',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked = 'Razorpay'
                                            : whichPaymentIsChecked =
                                                'Cash on Delivery';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Razorpay',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                      'https://cdn.iconscout.com/icon/free/png-256/free-razorpay-1649771-1399875.png',
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(useRazorpay),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(usePaystack),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: whichPaymentIsChecked ==
                                                  'Paystack'
                                              ? primaryColor
                                              : secondaryColor3
                                                  .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value: whichPaymentIsChecked == 'Paystack',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked = 'Paystack'
                                            : whichPaymentIsChecked = 'Paypal';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Paystack',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/0/0b/Paystack_Logo.png',
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(usePaystack),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(useFlutterwave),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: whichPaymentIsChecked ==
                                                  'Flutterwave'
                                              ? primaryColor
                                              : secondaryColor3
                                                  .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value:
                                        whichPaymentIsChecked == 'Flutterwave',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked =
                                                'Flutterwave'
                                            : whichPaymentIsChecked = 'Paypal';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Flutterwave',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/9/9e/Flutterwave_Logo.png',
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(useFlutterwave),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(useWebview),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              whichPaymentIsChecked == 'Webview'
                                                  ? primaryColor
                                                  : secondaryColor3
                                                      .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value: whichPaymentIsChecked == 'Webview',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked = 'Webview'
                                            : whichPaymentIsChecked = 'Paypal';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Webview',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                      'https://logodix.com/logo/410270.png',
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(useWebview),
                                const SizedBox(
                                  height: 10.0,
                                ).visible(useCashOnDelivery),
                                Material(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: whichPaymentIsChecked ==
                                                  'Cash on Delivery'
                                              ? primaryColor
                                              : secondaryColor3
                                                  .withOpacity(0.1))),
                                  color: Colors.white,
                                  child: CheckboxListTile(
                                    value: whichPaymentIsChecked ==
                                        'Cash on Delivery',
                                    checkboxShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onChanged: (val) {
                                      setState(() {
                                        val == true
                                            ? whichPaymentIsChecked =
                                                'Cash on Delivery'
                                            : whichPaymentIsChecked = 'Paypal';
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(10.0),
                                    activeColor: primaryColor,
                                    title: const Text(
                                      'Cash on Delivery',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    secondary: Image.network(
                                      'https://w7.pngwing.com/pngs/483/386/png-transparent-advance-payment-computer-icons-invoice-money-cash-on-delivery-blue-text-trademark-thumbnail.png',
                                      height: 50.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ).visible(useCashOnDelivery),
                                const SizedBox(height: 20),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ///_____Cost_Section_____________
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         'Your Order',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Subtotal',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: textColors,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Consumer<CartNotifier>(builder:
                                                    (context, provider, child) {
                                                  return Text(
                                                    widget.couponPrice == null
                                                        ? '\$${provider.cartTotalPriceF(initialValue)}'
                                                        : '\$${provider.cartTotalPriceF(initialValue) - provider.promoPrice}',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                 'Discount',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: textColors,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  '\$${widget.couponPrice}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )
                                              ],
                                            ).visible(
                                                widget.couponPrice != null),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            width: 1,
                                            color: textColors,
                                          ))),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                             'Total Amount',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Consumer<CartNotifier>(builder:
                                                (context, provider, child) {
                                              return Text(
                                                widget.couponPrice == null
                                                    ? '\$${provider.cartTotalPriceF(initialValue)}'
                                                    : '\$${provider.cartTotalPriceF(initialValue) - provider.promoPrice}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                    Consumer<CartNotifier>(
                                        builder: (context, provider, child) {
                                      // final cart = provider.read(cartNotifier);

                                      return Button1(
                                        buttonText: 'Proceed to Checkout',
                                        buttonColor: primaryColor,
                                        onPressFunction: () => _handlePayment(
                                          provider,
                                        ),
                                      );
                                    }),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const CheckOutShimmerWidget();
                }
              }),
          RedeemConfirmationScreen(
            image: 'https://cdn.shopify.com/app-store/listing_images/a896e86d52fb7b15543c88e242eca7cc/promotional_image/COr0qZq7nvwCEAE=.png?height=720&width=1280',
            mainText: 'Order successfully!',
            subText:  'Your order will be delivered soon. Thank you.',
            buttonText:  'Back to Home',
          ).visible(isSuccess)
        ]),
      ),
    );
  }

  //Handle Multiple Payment system
  _handlePayment(
    CartNotifier cart,
  ) {
    switch (whichPaymentIsChecked) {
      case 'Razorpay':
        // _handleRazorpayPayment(cart, ref);
        break;
      case 'Paypal':
        _handlePaypalPayment(cart);
        break;
      case 'Flutterwave':
        _handleFlutterwavePayment(cart);
        break;
      case 'Paystack':
        // _handlePayStackPayment(cart, ref);
        break;
      case 'Stripe':
        _handleStripePayment(
          cart,
        );
        break;
      case 'Paytm':
        PaytmConfig().generateTxnToken(
            widget.couponPrice == null
                ? cart.cartTotalPriceF(initialValue)
                : (cart.cartTotalPriceF(initialValue) - cart.promoPrice),
            DateTime.now().millisecondsSinceEpoch.toString());
        break;
      case 'Webview':
        _handleWebviewPayment(cart);
        break;
      case 'Cash on Delivery':
        _handleCashOnDelivery(cart);
        break;
      default:
        _handleCashOnDelivery(cart);
    }
  }

  //Web Checkout Payment System
  _handleWebviewPayment(CartNotifier cart) {
    EasyLoading.show(
      status:  'Creating Order...',
    );
    apiService
        ?.createOrder(retrieveCustomer!, lineItems, 'Cash on Delivery', false,
            cart.coupon)
        .then((value) async {
      if (value) {
        var snap = await cart.getListOfOrder();
        if (snap.isNotEmpty) {
          // ignore: use_build_context_synchronously
          MyWebView(
            url: snap[0].paymentUrl,
            id: snap[0].id.toString(),
          ).launch(context);
        }

        EasyLoading.dismiss(animation: true);
        cart.cartOtherInfoList.clear();
        cart.cartItems.clear();
        cart.coupon.clear();
        cart.getListOfOrder();
      } else {
        EasyLoading.showError('Failed with Error');
      }
    });
  }

//Cash on Delivery Payment
  _handleCashOnDelivery(CartNotifier cart) {
    _handleOrderCreate(false, 'Cash On Delivery', cart);
  }

  //Stripe Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': stripeCurrency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  _handleStripePayment(
    CartNotifier cart,
  ) async {
    try {
      int amount = widget.couponPrice == null
          ? cart.cartTotalPriceF(initialValue).toInt()
          : (cart.cartTotalPriceF(initialValue) - cart.promoPrice).toInt();
      //STEP 1: Create Payment Intent
      var paymentIntent =
          await createPaymentIntent((amount * 100).toString(), stripeCurrency);
      Stripe.publishableKey = stripePublishableKey;
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: "Maanstore Furniture"));

      //STEP 3: Display Payment sheet
      await Stripe.instance.presentPaymentSheet().then((value) {
        _handleOrderCreate(true, 'Stripe', cart);
        paymentIntent = null;
      });
    } on StripeException catch (e) {
      EasyLoading.showError(e.error.message.toString());
    }
  }

  _handlePaypalPayment(CartNotifier cart) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: sandbox,
            clientId: paypalClientId,
            secretKey: paypalClientSecret,
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: [
              {
                "amount": {
                  "total": widget.couponPrice == null
                      ? cart.cartTotalPriceF(initialValue).toString()
                      : (cart.cartTotalPriceF(initialValue) - cart.promoPrice)
                          .toString(),
                  "currency": paypalCurrency,
                  "details": {
                    "subtotal": widget.couponPrice == null
                        ? cart.cartTotalPriceF(initialValue).toString()
                        : (cart.cartTotalPriceF(initialValue) - cart.promoPrice)
                            .toString(),
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": "Grocery Order From MaanGrocery",
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                "item_list": {
                  "items": [
                    {
                      "name": "Grocery Order From MaanGrocery",
                      "quantity": 1,
                      "price": widget.couponPrice == null
                          ? cart.cartTotalPriceF(initialValue).toString()
                          : (cart.cartTotalPriceF(initialValue) -
                                  cart.promoPrice)
                              .toString(),
                      "currency": paypalCurrency,
                    }
                  ],
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              _handleOrderCreate(true, 'Paypal', cart);
            },
            onError: (error) {
              EasyLoading.showError(error.toString());
            },
            onCancel: (params) {
              EasyLoading.showInfo(
                  'Payment has been cancelled. Please try again');
            }),
      ),
    );
  }

  _handleOrderCreate(
    bool payment,
    String methodName,
    CartNotifier cart,
  ) {
    EasyLoading.show(
      status: 'Creating Order...',
    );
    apiService
        ?.createOrder(
            retrieveCustomer!, lineItems, methodName, payment, cart.coupon)
        .then((value) async {
      if (value) {
        setState(() {
          isSuccess = true;
        });
        EasyLoading.showSuccess('Order Placed Successfully');
        cart.cartOtherInfoList.clear();
        cart.cartItems.clear();
        cart.coupon.clear();
        cart.getListOfOrder();
      } else {
        EasyLoading.showError('Failed with Error');
      }
    });
  }

  _handleFlutterwavePayment(CartNotifier cart) async {
    final Customer customer = Customer(
      name:
          "${retrieveCustomer!.shipping!.firstName ?? ''} ${retrieveCustomer!.shipping!.lastName ?? ''}",
      phoneNumber: retrieveCustomer!.shipping!.phone ?? '',
      email: retrieveCustomer!.email ?? '',
    );
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: flutterwavePublicKey,
        currency: flutterwaveCurrency,
        redirectUrl: 'https://facebook.com',
        txRef: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: widget.couponPrice == null
            ? cart.cartTotalPriceF(initialValue).toString()
            : (cart.cartTotalPriceF(initialValue) - cart.promoPrice).toString(),
        customer: customer,
        paymentOptions: "card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Test Payment"),
        isTestMode: sandbox);
    final ChargeResponse response = await flutterwave.charge();
    if (response.success == true) {
      _handleOrderCreate(true, 'Flutterwave', cart);
    } else {}
  }
}

class MyWebView extends StatefulWidget {
  const MyWebView({Key? key, required this.url, required this.id})
      : super(key: key);
  final String url;
  final String id;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool isPaf = false;
  WebViewController? _controller;

  Future<bool> _willPopCallback() async {
    bool canNavigate = await _controller!.canGoBack();
    if (canNavigate) {
      _controller!.goBack();
      return false;
    } else {
      Future.delayed(const Duration(milliseconds: 1))
          .then((value) => NavigationBarScreen().launch(context));
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(currentUrl?.indexOf('?'));
    // print(currentUrl?.substring(0, currentUrl?.indexOf('?')));
    // print(Config.orderConfirmUrl + widget.id.toString());
    return Scaffold(
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: Stack(
          children: [
            WebView(
              onPageFinished: (url) {
                int position = url.indexOf('?') - 1;
                if (url.substring(0, position) ==
                    (Config.orderConfirmUrl + widget.id)) {
                  setState(() {
                    isPaf = true;
                  });
                }
              },
              initialUrl: widget.url,
              gestureNavigationEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) async {
                _controller = webViewController;
                
              }, 
            ),
            RedeemConfirmationScreen(
              image: "https://cdn.shopify.com/app-store/listing_images/a896e86d52fb7b15543c88e242eca7cc/promotional_image/COr0qZq7nvwCEAE=.png?height=720&width=1280",
              mainText:'Order successfully!',
              subText: 'Your order will be delivered soon. Thank you.',
              buttonText: 'Back to Home',
            ).visible(isPaf),
          ],
        ),
      ),
    );
  }
}
