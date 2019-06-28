import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String email = "user2@gmail.com";
  final String password = "123456";
  final String url = "http://24586b8e.ngrok.io";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Emal',
                    ),
                  ),
                  Container(margin: EdgeInsets.only(bottom: 20.0)),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Emal',
                    ),
                  ),

                  Container(margin: EdgeInsets.only(bottom: 20.0)),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Emal',
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }

  Future<dynamic> login() async {
    final response = await http.post(
      '$url/loginuri',
      body: {
        'email': "user0@gmail.com"
      }
    ).then((response){
      print(response.statusCode);
      print(response.body);
    });
    // if ( response.statusCode == 200) return Post.fromJson(json.decode(response.body));
    // var convert = json.decode(response.body);
    // return convert;
  }

  Future<dynamic> register() async {
    final response = await http.post(
      '$url/registeruri',
      body: {
        "email":"user0@gmail.com"
      }
    )
    .then((response){
      print(response.statusCode);
      print(response.body);
    });
  }
}
