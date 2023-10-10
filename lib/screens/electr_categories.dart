import 'package:flutter/material.dart';
import 'package:mytok/screens/order_screen.dart';
import 'package:mytok/utils/colors.dart';

class ElectrCategories extends StatelessWidget {
  const ElectrCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elektr xizmatlari"),
        backgroundColor: AppColors.yellow,
      ),
      body: Container(
        // color: Colors.blueAccent,
        margin: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: 10),
        // width: (MediaQuery.of(context).size.width * 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Order(
                        job_title: "Montaj",
                        avatar: "assets/images/montaj.png",
                        description: "3 xil turdagi montaj ishlari"),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xe5e7e7e7),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/montaj.png",
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Montaj",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.black),
                          ),
                          // SizedBox(
                          //   height: 3.0,
                          // ),
                          Text(
                            "3 xil turdagi montaj ishlari",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Order(
                        job_title: "Vklyuchatel",
                        avatar: "assets/images/vklyuchatel.png",
                        description: "Vklyuchatel va rozetka o'rnatish"),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Color(0xe5e7e7e7),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/vklyuchatel.png",
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vklyuchatel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.black),
                          ),
                          // SizedBox(
                          //   height: 3.0,
                          // ),
                          Text(
                            "Vklyuchatel va rozetka o'rnatish",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Order(
                        job_title: "Qandil o'rnatish",
                        avatar: "assets/images/qandil.png",
                        description: "Qandillar va lampalar o'rnatish"),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xe5e7e7e7),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/qandil.png",
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Qandil o'rnatish",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.black),
                          ),
                          // SizedBox(
                          //   height: 3.0,
                          // ),
                          Text(
                            "Qandillar va lampalar o'rnatish",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Order(
                        job_title: "Shit ishlari",
                        avatar: "assets/images/shit.png",
                        description: "Shit yig'ish va sozlash"),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xe5e7e7e7),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/shit.png",
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shit ishlari",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.black),
                          ),
                          // SizedBox(
                          //   height: 3.0,
                          // ),
                          Text(
                            "Shit yig'ish va sozlash",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Order(
                        job_title: "Simyogoch",
                        avatar: "assets/images/simyogoch.png",
                        description: "Simyogoch ishlari"),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xd5e7e7e7),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/simyogoch.png",
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Simyogoch",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.black),
                          ),
                          // SizedBox(
                          //   height: 3.0,
                          // ),
                          Text(
                            "Simyogoch ishlari",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
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
            case 3:
              // Navigate to HomeScreen

              break;
            default:
              // Do nothing
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Tarix"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Bog'lanish"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
