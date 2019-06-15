import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

//Save to XML file

Future<bool> setData (Map<String, dynamic> data, String directory) async {
  String convert = jsonEncode(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(directory, convert);
  return prefs.commit();
}

Future<bool> setUserID(String data, String directory) async {
  String convert = jsonEncode(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(directory, convert);
  return prefs.commit();
}

Future<Map<String, dynamic>> fetchData(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> dataParse = jsonDecode(prefs.getString(path));
  return dataParse;
}

Future<String> fetchId(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = jsonDecode(prefs.getString(path));
  return id;
}