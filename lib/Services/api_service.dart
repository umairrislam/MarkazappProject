import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';



import 'package:http/http.dart' as http;
import 'package:markazapp/Models/coupens_model.dart';
import 'package:markazapp/Models/customer_model.dart';
import 'package:markazapp/Models/ordercreate_model.dart' as order_create ;

import 'package:markazapp/Models/retrive_customermodel.dart';
import 'package:markazapp/Screens/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    final prefs = await SharedPreferences.getInstance();

    var authToken = base64Encode(
      utf8.encode('${Config.key}:${Config.secret}'),
    );
    bool ret = false;
    try {
      var response = await Dio().post(
        Config.url + Config.customerURL,
        data: model.toJson(),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: 'application/json'
        }),
      );
      if (response.statusCode == 201) {
        ret = true;
        await prefs.setInt('customerId', response.data['id']);
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

  Future<bool> loginCustomer(String userName, String password) async {
    final prefs = await SharedPreferences.getInstance();

    bool ret = false;

    try {
      var response = await Dio().post(Config.tokenURL,
          data: {
            'username': userName,
            'password': password,
          },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
          }));
      print(response);
      if (response.statusCode == 200) {
        await prefs.setInt('customerId', response.data['data']['id']);
        await prefs.setString(
            'token', response.data['data']['token'].toString());

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

  Future<bool> createOrder(
    RetrieveCustomer retrieveCustomer,
    List<order_create.LineItemss> lineItems,
    String paymentName,
    bool setPaid,
    List<order_create.CouponLines> coupons,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final int? customerId = prefs.getInt('customerId');
    var authToken = base64Encode(
      utf8.encode('${Config.key}:${Config.secret}'),
    );
    bool ret = false;
    try {
      var response = await Dio().post(
        Config.url + Config.createOrderUrl,
        data: {
          "payment_method": paymentName,
          "payment_method_title": paymentName,
          "customer_id": customerId,
          "set_paid": setPaid,
          "billing": {"phone": retrieveCustomer.billing!.phone},
          "shipping": retrieveCustomer.shipping,
          "line_items": lineItems,
          "coupon_lines": coupons
        },
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );
      if (response.statusCode == 201) {
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

  Future<double> retrieveCoupon(String couponCode, double totalAmount) async {
    RetrieveCoupon coupons = RetrieveCoupon();

    double amount = 0;
    String url =
        '${Config.url}${Config.coupons}?consumer_key=${Config.key}&consumer_secret=${Config.secret}&code=$couponCode';
    var response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (Map i in data) {
        coupons = RetrieveCoupon.fromJson(i);
      }
      if (coupons.discountType == 'percent') {
        amount =
            ((totalAmount * double.parse(coupons.amount.toString()) / 100));
      } else if (coupons.discountType == 'fixed_cart') {
        amount = double.parse(coupons.amount.toString());
      }
      return amount;
    } else {
      return amount;
    }
  }

  Future<bool> updateProfile(
      RetrieveCustomer retrieveCustomer, String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final int? customerId = prefs.getInt('customerId');
    String url = '${Config.url}${Config.customerDetails}$customerId';
    var authToken = base64Encode(
      utf8.encode('${Config.key}:${Config.secret}'),
    );
    bool ret = false;
    try {
      var response = await Dio().put(
        url,
        data: {
          "first_name": retrieveCustomer.firstName,
          "last_name": retrieveCustomer.lastName,
          "email": retrieveCustomer.email,
          "billing": {
            "phone": phoneNumber,
          }
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

  Future<bool> updateShippingAddress(RetrieveCustomer retrieveCustomer) async {
    final prefs = await SharedPreferences.getInstance();
    final int? customerId = prefs.getInt('customerId');
    String url = '${Config.url}${Config.customerDetails}$customerId';
    var authToken = base64Encode(
      utf8.encode('${Config.key}:${Config.secret}'),
    );
    bool ret = false;
    try {
      var response = await Dio().put(
        url,
        data: {
          "first_name": retrieveCustomer.shipping!.firstName,
          "last_name": retrieveCustomer.shipping!.lastName,
          "billing": {
            "phone": retrieveCustomer.billing?.phone,
          },
          "shipping": {
            "first_name": retrieveCustomer.shipping!.firstName,
            "last_name": retrieveCustomer.shipping!.lastName,
            "address_1": retrieveCustomer.shipping!.address1,
            "address_2": retrieveCustomer.shipping!.address2,
            "city": retrieveCustomer.shipping!.city,
            "state": retrieveCustomer.shipping!.state,
            "postcode": retrieveCustomer.shipping!.postcode,
            "country": retrieveCustomer.shipping!.country
          }
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
