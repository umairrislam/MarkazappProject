import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:markazapp/Models/listoforder_model.dart';
import 'package:markazapp/Screens/config.dart';

class UpdateProvider extends ChangeNotifier {
  List<ListOfOrders> orders = [];

  Future<bool> updateOrder(int orderId, String reason) async {
    String url = '${Config.url}${Config.anOrderUrl}$orderId';
    var authToken = base64Encode(
      utf8.encode('${Config.key}:${Config.secret}'),
    );
    bool ret = false;
    try {
      var response = await Dio().put(
        url,
        data: {
          "status": "cancelled",
          "customer_note": reason,
        },
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }
}
