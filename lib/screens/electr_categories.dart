import 'package:flutter/material.dart';
import 'package:mytok/utils/colors.dart';

class ElectrCategories extends StatelessWidget {
  const ElectrCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Elektr xizmatlari"),
        backgroundColor: AppColors.yellow,
      ),
      body: Container(
        // color: Colors.blueAccent,
        margin: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: 10),
        // width: (MediaQuery.of(context).size.width * 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xe5e7e7e7),
                  borderRadius: BorderRadius.circular(25)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pdf1');
                },
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
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xe5e7e7e7),
                  borderRadius: BorderRadius.circular(25)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pdf1');
                },
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
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xe5e7e7e7),
                  borderRadius: BorderRadius.circular(25)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pdf1');
                },
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
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xe5e7e7e7),
                  borderRadius: BorderRadius.circular(25)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pdf1');
                },
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
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xd5e7e7e7),
                  borderRadius: BorderRadius.circular(25)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pdf1');
                },
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
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
