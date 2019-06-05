import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

Future<bool> setData (Map<String, dynamic> data) async {
  String convert = jsonEncode(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('dataSignUp', convert);
  return prefs.commit();
}

Future<Map<String, dynamic>> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> dataParse = jsonDecode(prefs.getString('dataSignUp'));
  return dataParse;
}