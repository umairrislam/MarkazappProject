
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:markazapp/Models/categories_model.dart';

class CategoriesProvider extends ChangeNotifier {
  bool _isloading = true;
  bool get isloading => _isloading;
  List<CategoriesModel> _categoriees = [];
  List<CategoriesModel> get categoriies =>_categoriees;
  Future<void> getAllcategorieslists ()async{
    _isloading = true;
    print("category}");
    String url='https://shop.althrift.com/wp-json/wc/v3/products/categories?consumer_key=ck_ba1627f08cf4bd79d7deccacd606a879da21f319&consumer_secret=cs_d026cfafedfaacac96ea30d50e3ddf860370ed53&per_page=100';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
  
    if (response.statusCode==200){

      _categoriees= [];
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
         _categoriees = postData.forEach((categ)=>  _categoriees.add(CategoriesModel.fromJson(categ)));
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

