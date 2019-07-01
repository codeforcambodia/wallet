import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

checkConnection(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('No internet'),
          content: Text("You're not connect to network"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ]
        );
      }
    );
    return false;
  }
  return true;
}


