import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './UserModel.dart';


List<GetApiList> parseGetApiList(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var getApiLists = list.map((model) => GetApiList.fromJson(model)).toList();
  return getApiLists;
}
 String uri = "https://jsonplaceholder.typicode.com/users";
Future<List<GetApiList>> fetchGetApiList() async {
  //final response = await http.get('https://jsonplaceholder.typicode.com/users');
  var response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    return compute(parseGetApiList, response.body);
  } else {
    throw Exception("Request Api Error");
  }
}
