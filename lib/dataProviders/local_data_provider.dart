import 'dart:convert';
import 'dart:developer';


import 'package:myapp/dataProviders/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider {
  SharedPreferences sharedPreferences;

  LocalDataProvider({required this.sharedPreferences});

  Future<void> cacheData({
    required String key,
    required dynamic data,
  }) {
    log("setting sharedPreferences");
    log("key $key");
    log('cached data is $data');
    return sharedPreferences.setString(key, json.encode(data));
  }

  dynamic getCachedData({
    required String key,
    required retrievedDataType,
    dynamic returnType,
  }) {
    try {
      if (sharedPreferences.getString(key) != null) {
        if (returnType == List) {
          final List<dynamic> data = json.decode(
            sharedPreferences.getString(key) ?? '',
          );

          return retrievedDataType.fromJsonList(data);
        } else if (returnType == String) {
          final dynamic data = json.decode(
            sharedPreferences.getString(key) ?? '',
          );

          return data;
        } else {
          final dynamic data = json.decode(
            sharedPreferences.getString(key) ?? '',
          );

          try {
            return retrievedDataType.fromJson(data);
          } catch (e) {
            return data;
          }
        }
      } else {
        throw CacheException();
      }
    } catch (_) {
      // throw CacheException();
    }
  }

  Future<bool> clearCache({
    required String key,
  }) {
    return sharedPreferences.remove(key);
  }

/*
  Future<bool> addToCart({required CartModel data}) {
    if (sharedPreferences.getString('CACHED_CART') != null) {
      print('cart is not null');
      bool newItem = true;
      dynamic userCart = sharedPreferences.getString('CACHED_CART');
      print('user cart is $userCart');
      List<dynamic> cart = jsonDecode(userCart);

      cart.forEach((element) {
        if (
            element['name'] == data.name &&
            element['platform_id'] == data.platform_id &&
            element['platformUserId'].toString() ==
                data.user_platform_id.toString()) {
          element['counter'] = (int.parse(element['counter'].toString()) +
              int.parse(data.counter.toString(),));
          // element['price'] = (int.parse(element['price'].toString()) +
          //     int.parse(data.price.toString(),));
          newItem = false;
          return;
        }
      });

      if (newItem) {
        print('new item');
        cart.add(data);
        newItem = false;
      }

      return sharedPreferences.setString('CACHED_CART', json.encode(cart));
    } else {
      print('cart is null');

      List<CartModel> cart = [];
      cart.add(data);

      return sharedPreferences.setString('CACHED_CART', json.encode(cart));
    }
  }
*/
}
