
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:markazapp/Models/product_model.dart';





class FeaturedProvider extends ChangeNotifier {
  bool _isloading = true;
  bool get isloading => _isloading;
  List<ProductModel> _product = [];
  List<ProductModel> get features =>_product;
  Future<void> getAllLatestfeaturelists ()async{
    _isloading = true;
    print("category}");
    String url='https://shop.althrift.com/wp-json/wc/v3/products?order=desc&consumer_key=ck_ba1627f08cf4bd79d7deccacd606a879da21f319&consumer_secret=cs_d026cfafedfaacac96ea30d50e3ddf860370ed53&orderby=date&featured=1';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
  
    if (response.statusCode==200){

      _product= [];
       print(response.body.toString());
      _isloading = false;
      final data = jsonDecode(response.body);
        print('starts body');
      print(response.body.toString());
       print('starts body data');
      print(data);
      final postData = data;
      print(data.toString());
      try {
         _product = postData.forEach((categ)=>  _product.add(ProductModel.fromJson(categ)));
      }
      catch(e,s){
        print(e.toString());
        print(s.toString());
        _isloading = true;
      }
    }
    else{
_isloading = true;
    }
   notifyListeners(); 
  }
} 

