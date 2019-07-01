import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// String email;
final _url = "https://api.zeetomic.com";

Future<Map<String, dynamic>> user_register(String email) async {
  final response = await http.post('$_url/registeruri', body: {"email": "$email"});
  return json.decode(response.body);
}

Future<Map<String, dynamic>> user_login(String email, String passwords) async {
  final response = await http.post('$_url/loginuri', body: {"email": email, "passwords": passwords});
  return json.decode(response.body);
}

// Future<Map<String, dynamic>> find_user(Strin) async {
//   final response = await http.post(
//     "$_url/finduser",
//     body: {
//       "email"
//     }
//   )
// }
