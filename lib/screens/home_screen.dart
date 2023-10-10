import 'package:flutter/material.dart';
import 'package:mytok/screens/contact.dart';
import 'package:mytok/screens/electr_categories.dart';
import 'package:mytok/screens/orders.dart';
import 'package:mytok/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mytok/utils/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Image.asset("assets/images/logo.png"),
                      width: 40,
                    ),
                    // Icon(
                    //   Icons.dashboard,
                    //   size: 30,
                    //   color: Colors.white,
                    // ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 18),
                        Text("Sirdaryo", style: TextStyle(fontSize: 18),)
                      ],
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.black,
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(left: 3, bottom: 15),
                //       child: Text(
                //         "MyTok",
                //         style: TextStyle(
                //             fontWeight: FontWeight.w600,
                //             fontSize: 30,
                //             color: AppColors.black,
                //             letterSpacing: 1,
                //             wordSpacing: 1),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                // Text('Xizmatlarimiz', style: TextStyle(fontSize: 20),),
                // SizedBox(
                //   height: 20,
                // ),
                InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const TextLocation()));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ElectrCategories()));
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFF5F3FF)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: Image.asset("assets/images/electr.png"),
                        ),
                        SizedBox(height: 20,),
                        Text("Elektr ishlari", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    padding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFF5F3FF)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: Image.asset("assets/images/plumbing.png"),
                        ),
                        SizedBox(height: 20,),
                        Text("Santexnika ishlari", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
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
          else if(index == 2){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ContactScreen()));
          }
          else if(index == 3){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        letIndexChange: (index) => true,
      ),


      // bottomNavigationBar: BottomNavigationBar(
      //   showUnselectedLabels: true,
      //   iconSize: 25,
      //   selectedItemColor: AppColors.black,
      //   selectedFontSize: 18,
      //   currentIndex: 0,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (index) {
      //     // Handle navigation based on the tapped index
      //     switch (index) {
      //       case 1:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => MyOrders()));
      //
      //         break;
      //       case 3:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const Profile()));
      //       case 2:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const CheckCart()));
      //
      //         break;
      //       default:
      //         // Do nothing
      //         break;
      //     }
      //   },
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: "Tarix"),
      //     BottomNavigationBarItem(icon: Icon(Icons.call), label: "Bog'lanish"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label: "Profil"),
      //   ],
      // ),
    );
  }
}
