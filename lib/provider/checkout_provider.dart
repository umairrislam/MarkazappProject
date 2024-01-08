import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:markazapp/Models/retrive_customermodel.dart';
import 'package:markazapp/Screens/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class checkOutProvider extends ChangeNotifier {
  Future<RetrieveCustomer> getCustomerDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final int? customerId = prefs.getInt('customerId');

    String url =
        '${Config.url}${Config.customerDetails}$customerId?consumer_key=${Config.key}&consumer_secret=${Config.secret}';
    var response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return RetrieveCustomer.fromJson(data);
    } else {
      return RetrieveCustomer.fromJson(data);
    }
  }
}
