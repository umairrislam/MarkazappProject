import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:markazapp/Models/listoforder_model.dart';
import 'package:markazapp/Screens/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class listOfOrderProvider extends ChangeNotifier {
  List<ListOfOrders> listOfOrders = [];
  Future<List<ListOfOrders>> getListOfOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final int? customerId = prefs.getInt('customerId');

    String url =
        '${Config.url}orders?consumer_key=${Config.key}&consumer_secret=${Config.secret}';
    var response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);
    listOfOrders.clear();
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
