import 'package:flutter/material.dart';
import 'package:mytok/utils/colors.dart';


class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Yangi buyurtma"), centerTitle: true, backgroundColor: AppColors.yellow,),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.06, vertical: h*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/shit.png", width: w*0.2,),
              SizedBox(height: h*0.02,),
              Text("Shit ishlari", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Text("Shit o'rnatish va sozlash", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
              
            ],
          ),
        ),
      ),

    );
  }
}
