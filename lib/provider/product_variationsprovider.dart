import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:markazapp/Models/productvariations_model.dart';
import 'package:markazapp/Screens/config.dart';

class singleProductVariationProvider extends ChangeNotifier {
  bool _isloading = true;
  bool get isloading => _isloading;

  List<SingleProductVariations> _productVariation = [];

  List<SingleProductVariations> get productVariation => _productVariation;

  Future<void> getSingleProductVariation(productID) async {
    _isloading = true;
    String url =
        '${Config.url}products/$productID/variations?consumer_key=${Config.key}&consumer_secret=${Config.secret}&per_page=50';
    print(url);
    final Url = Uri.parse(url);

    final response = await http.get(Url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var productData = jsonData;
      print(productData);
      try {
        productData.forEach((data) =>
            _productVariation.add(SingleProductVariations.fromJson(data)));
      } catch (e, s) {
        print(e.toString());
        print(s.toString());
      }
      _isloading = false;
      notifyListeners();
    } else {
      _isloading = true;
      throw Exception('Failed to load Categories');
    }
  }


}
