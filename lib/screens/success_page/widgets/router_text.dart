import 'package:flutter/material.dart';

import '../../sizeConfig.dart';


class RouterText extends StatelessWidget {
  const RouterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: h*0.1, bottom: w*0.2),  /// 8.0-8.0
      child: Text("Buyurtma yuborildi!", style: TextStyle(color: Colors.black54, fontSize:h/27.32)),   /// 25
    );
  }
}
