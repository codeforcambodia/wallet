import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

Future<bool> setData (Map<String, dynamic> data) async {
  String convert = jsonEncode(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('dataSignUp', convert);
  return prefs.commit();
}

Future<Map<String, dynamic>> fetchPersonalData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> dataParse = jsonDecode(prefs.getString('dataSignUp'));
  print(dataParse['personal'].length);
  return dataParse;
}

Future<Map<String, dynamic>> fetchBooksData() async {
  
}