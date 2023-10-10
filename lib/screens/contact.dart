import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/profile.dart';

import 'orders.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Contact"),),
      body: Container(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
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
          if(index == 1){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyOrders()));
          }
          else if(index == 0){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
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
