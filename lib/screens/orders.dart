import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/profile.dart';
import 'package:mytok/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'contact.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late int status = 0;
  var box = Hive.box('users');
  List<Map<String, dynamic>> ordersData = [];

  Future<void> fetchData() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mytok.uz/API/alluseridorder.php'));
    request.fields.addAll({'userid': '${box.get('id')}'});
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult != ConnectivityResult.none){
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        if (res == "Taqdim etilgan ID uchun hech qanday ma'lumot topilmadi") {
          status = 2;
        } else {
          final data = json.decode(res);
          setState(() {
            status = 1;
            ordersData = List<Map<String, dynamic>>.from(data);
          });
        }
      } else {
        setState(() {
          status = -1;
        });
      }
    }
    else{
      setState(() {
        status = -2;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyurtmalarim"),
        backgroundColor: AppColors.yellow,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.update,
              size: w * 0.08,
            ),
            onPressed: () {
              setState(() {
                status = 0;
              });
              fetchData();
            },
          )
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (status == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == 2) {
            return Center(
              child: Text('Buyurtmalar topilmadi'),
            );
          } else if (status == -1) {
            return Center(
              child: Text('API da nosozlik'),
            );
          } else if (status == -2) {
            return Center(
              child: Text('Internetga ulanmagansiz'),
            );
          } else {
            final data = ordersData;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text(item['category'] ?? ''),
                  subtitle: Text(item['titile'] ?? ''),
                  leading: _buildLeadingIcon(item['category']),
                  trailing: _buildIcon(item['order_status'])
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: h * 0.08,
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
          if (index == 0) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ContactScreen()));
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  Widget _buildLeadingIcon(String category) {
    if (category == "Montaj") {
      return CircleAvatar(
        child: Image.asset("assets/images/montaj.png"),
      );
    } else if (category == "Shit ishlari") {
      return CircleAvatar(
        child: Image.asset("assets/images/shit.png"),
      );
    }else if (category == "Vklyuchatel") {
      return CircleAvatar(
        child: Image.asset("assets/images/vklyuchatel.png"),
      );
    }else if (category == "Simyog'och") {
      return CircleAvatar(
        child: Image.asset("assets/images/simyogoch.png"),
      );
    }else if (category == "Qandil o'rnatish") {
      return CircleAvatar(
        child: Image.asset("assets/images/qandil.png"),
      );
    }else {
      return CircleAvatar(
        child: Image.asset("assets/images/simyogoch.png"),
      );
    }
  }


  Widget _buildIcon(String category) {
    if (category == "0") {
      return Container(width: 20, height: 20,child: CircularProgressIndicator(color: Colors.black,));
    } else {
      return Icon(Icons.check);
    }
  }
}
