import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:markazapp/Models/product_model.dart';

import 'package:markazapp/Screens/config.dart';

class Productprovider extends ChangeNotifier {
  bool _isloading = true;
  bool get isloading => _isloading;
  List<ProductModel> _posts = [];
  List<ProductModel> get products => _posts;
    late ProductModel _productDetail;
  ProductModel get productDetail => _productDetail;

  Future<void> getCatPost(categoryId) async {
    _isloading = true;
    print("categoryId $categoryId");
    final String Product_urlhere =
        '${Config.url}${Config.productsURL}?category=$categoryId&consumer_key=${Config.key}&consumer_secret=${Config.secret}&per_page=100';
    final uri = Uri.parse(Product_urlhere);

    try {
      final response = await http.get(uri);
      print(uri);
      if (response.statusCode == 200) {
        _posts =[];
        print(response.body.toString());
        _isloading = false;
        final data = json.decode(response.body);
        print('starts body');
        print(response.body.toString());
        print('starts body data');
        print(data);
        final postData = data;
        print(data.toString());
        postData.forEach((data) =>
            _posts.add(ProductModel.fromJson(data)));
      } else {
        _isloading = true;
      }
    } catch (e,s) {
      // Handle the exception (e.g., show an error message)
      _isloading = true; 
            print('error show');

      print(e.toString());
            print(s.toString());

      // Consider setting _isloading to false in case of an error
    }

    notifyListeners();
  }


  Future<void> getProductDetails(productId) async {
    _isloading = true;
    print("categoryId $productId");
    final String Product_urlhere =
        '${Config.url}${Config.productsURL}/${productId}?consumer_key=${Config.key}&consumer_secret=${Config.secret}&per_page=100';
    final uri = Uri.parse(Product_urlhere);

    try {
      final response = await http.get(uri);
      print(uri);
      if (response.statusCode == 200) {
        _posts =[];
        print(response.body.toString());
        _isloading = false;
        final data = json.decode(response.body);
        print('starts body');
        print(response.body.toString());
        print('starts body data');
        print(data);
        final postData = data;
        print(data.toString());
        _productDetail =
            ProductModel.fromJson(data);
      } else {
        _isloading = true;
      }
    } catch (e,s) {
      // Handle the exception (e.g., show an error message)
      _isloading = true; 
            print('error show');

      print(e.toString());
            print(s.toString());

      // Consider setting _isloading to false in case of an error
    }

    notifyListeners();
  }


}
