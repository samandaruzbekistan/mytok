import 'package:flutter/material.dart';
import 'package:mytok/screens/orders.dart';
import 'package:mytok/utils/colors.dart';

import '../../sizeConfig.dart';

class OkButton extends StatefulWidget {
  const OkButton({Key? key}) : super(key: key);

  @override
  _OkButtonState createState() => _OkButtonState();
}

class _OkButtonState extends State<OkButton> {

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyOrders()));
      },
      child: Container(
          width: w*0.8,        /// 200
          height: h*0.08,   /// 55
          decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(30)
          ),
          child: Center(child: Text("OK", style: TextStyle(color: Colors.black, fontSize: h*0.03, fontWeight: FontWeight.bold))) /// 18
      ),
    );
  }
}
