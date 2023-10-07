import 'package:flutter/material.dart';
import 'package:mytok/screens/electr_categories.dart';
import 'package:mytok/utils/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 15),
                      child: Text(
                        "MyTok",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: AppColors.black,
                            letterSpacing: 1,
                            wordSpacing: 1),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                Text('Xizmatlarimiz', style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
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
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 25,
        selectedItemColor: AppColors.black,
        selectedFontSize: 18,
        currentIndex: 0,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation based on the tapped index
          switch (index) {
            case 1:
              // Navigate to HomeScreen

              break;
            case 2:
              // Navigate to HomeScreen

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
