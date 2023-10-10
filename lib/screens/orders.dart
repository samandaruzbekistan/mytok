import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/profile.dart';
import 'package:mytok/utils/colors.dart';

import 'contact.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key,}) : super(key: key);
  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Buyurtmalarim"), backgroundColor: AppColors.yellow,),
      body: SingleChildScrollView(
        child: Container(
          child: Text("adsfasd"),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: h*0.08,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.history, size: 30),
          Icon(Icons.phone, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.yellow,
        buttonBackgroundColor: Colors.yellow,
        backgroundColor: Colors.white,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          if(index == 0){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
          }
          else if(index == 2){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ContactScreen()));
          }
          else if(index == 3){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
