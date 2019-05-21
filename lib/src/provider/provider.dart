import 'package:flutter/material.dart';
import '../bloc/bloc.dart';

class Provider extends InheritedWidget{

  final bloc = Bloc();
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return null;
  }

  Provider({Widget child}) : super(child: child);

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }

}