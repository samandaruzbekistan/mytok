import 'package:flutter/material.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/profile.dart';
import 'package:mytok/utils/colors.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key,}) : super(key: key);
  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buyurtmalarim"), backgroundColor: AppColors.yellow,),
      body: SingleChildScrollView(
        child: Container(
          child: Text("adsfasd"),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 25,

        selectedItemColor: AppColors.black,
        selectedFontSize: 18,
        currentIndex: 1,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation based on the tapped index
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()));

              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));

              break;
            default:
            // Do nothing
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Tarix"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Bog'lanish"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
