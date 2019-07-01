// import 'package:flutter/material.dart';
// import '../../../model/model.dart';

// class CardUser{

//   CardUser({userData});
//   Widget borderRow(User_Data data) {
//     return Container(
//       margin: const EdgeInsets.symmetric(
//         vertical: 16.0,
//         horizontal: 24.0
//       ),
//       child: Stack(
//         children: <Widget>[
//           userCard(),
//           Container(
//             margin: new EdgeInsets.fromLTRB(110.0, 16.0, 16.0, 16.0),
//             // constraints: new BoxConstraints.expand(),
//             color: Colors.red,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(height: 4.0,),
//                 Text('Daveat')
//               ],
//             ),
//           ),
//           userThumbnail(data),
//         ],
//       ),
//     );
//   }

//   Widget userCard() {
//     return Container(
//       height: 124.0,
//       margin: EdgeInsets.only(left: 46.0),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//           Color(hexColor('#0f0c29')).withOpacity(1.0),
//           Color(hexColor('#302b63')).withOpacity(1.0),
//           // Color(hexColor('#3b8d99')), 
//         ]
//         ),
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10.0,
//             offset: Offset(5.0, 10.0,)
//           )
//         ]
//       ),
//     );
//   }

//   Widget userThumbnail(User_Data data){
//     return Container(
//       margin: EdgeInsets.symmetric(
//         vertical: 22.0
//       ),
//       alignment: FractionalOffset.centerLeft,
//       child: CircleAvatar(
//         minRadius: 40.0,
//         maxRadius: 40.0,
//         backgroundImage: AssetImage('assets/avatar.png')
//       ),
//     );
//   }

// }