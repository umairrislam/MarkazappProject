import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:markazapp/Models/listoforder_model.dart';
import 'package:markazapp/Models/ordercreate_model.dart';
import 'package:markazapp/Screens/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


class CartNotifier extends ChangeNotifier {
  final cartItems = <LineItemss>[];
  final coupon = <CouponLines>[];
  double promoPrice = 0;
  final cartOtherInfoList = <CartOtherInfo>[];

  void increaseQuantity(int index) {
    cartOtherInfoList[index].quantity =
        cartOtherInfoList[index].quantity!.toInt() + 1;
    createLineItems();
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cartOtherInfoList[index].quantity! > 1) {
      cartOtherInfoList[index].quantity =
          cartOtherInfoList[index].quantity! - 1;
      createLineItems();
      notifyListeners();
    }
  }
  void createLineItems() {
    cartItems.clear();
    for (var element in cartOtherInfoList) {
      cartItems.add(LineItemss(
        productId: element.productId,
        quantity: element.quantity,
        variationId: element.variationId,
      ));
    }
  }

  double updatePrice(double value) {
    promoPrice = value;
    notifyListeners();
    return promoPrice;
  }

  void addCoupon(CouponLines couponLines) {
    coupon.add(couponLines);
    notifyListeners();
  }

  void addItemInfo(CartOtherInfo cart) {
    cartOtherInfoList.add(cart);
    createLineItems();
    notifyListeners();
  }

  void removeItemInfo(String name) {
    int? id;

    for (var element in cartOtherInfoList) {
      if (element.productName!.contains(name)) {
        id = element.productId;
      }
    }

    cartOtherInfoList.remove(
        cartOtherInfoList.firstWhere((element) => element.productName == name));
    cartItems
        .remove(cartItems.firstWhere((element) => element.productId == id));
    notifyListeners();
  }

  double cartTotalPriceF(quantity) {
    double cartTotalPrice = 0;
    for (var element in cartOtherInfoList) {
      cartTotalPrice = cartTotalPrice +
          (element.productPrice!.toDouble() * element.quantity!.toDouble());
    }
    return cartTotalPrice;
  }

  Future<List<ListOfOrders>> getListOfOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final int? customerId = prefs.getInt('customerId');

    List<ListOfOrders>? listOfOrders = [];

    String url =
        '${Config.url}orders?consumer_key=${Config.key}&consumer_secret=${Config.secret}';
    var response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        if (i['customer_id'] == customerId) {
          listOfOrders.add(ListOfOrders.fromJson(i));
        }
      }

      return listOfOrders;
    }
    return listOfOrders;
  }
}

class CartOtherInfo {
  int? variationId;
  int? productId;
  String? type;
  String? productName;
  String? productImage;
  double? productPrice;
  Color? productColor;
  String? productSize;
  int? quantity;

  List<dynamic>? attributesName;
  List<dynamic>? selectedAttributes;

  CartOtherInfo({
    this.variationId,
    this.productId,
    this.type,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productColor,
    this.productSize,
    this.quantity,
    this.attributesName,
    this.selectedAttributes,
  });
}
