import 'package:contactus/contactus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/profile.dart';
import 'package:mytok/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'orders.dart';

showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 8.0,
        contentPadding: EdgeInsets.all(18.0),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => launchUrl(Uri.parse('tel:' + "+998975672009"!)),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text('Telefon'),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () => launchUrl(Uri.parse('sms:' + "+998975672009"!)),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text('SMS'),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  final url = Uri.parse(
                    'https://t.me/' +
                        "998975672009"!.substring(
                          1,
                          "998975672009"!.length,
                        ),
                  );
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text('Telegram'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

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
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Bog'lanish"), centerTitle: true, backgroundColor: AppColors.yellow,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: h*0.1,),
              Image.asset("assets/images/logo.png", width: w*0.5,),
              SizedBox(height: h*0.05,),
              Visibility(
                visible: "https://mytok.uz" != null,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Typicons.link),
                    title: Text(
                      "Website" ?? 'Website',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: "Sail",
                      ),
                    ),
                    onTap: () => launchUrl(Uri.parse("https://mytok.uz"!)),
                  ),
                ),
              ),
              Visibility(
                visible: "+998975672009" != null,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Typicons.phone),
                    title: Text(
                      "Telefon" ?? 'Telefon',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: "Sail",
                      ),
                    ),
                    onTap: () => showAlert(context),
                  ),
                ),
              ),
              Visibility(
                visible: "https://t.me/" != null,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.telegram_outlined),
                    title: Text(
                      "Telegram bot" ?? 'Website',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: "Sail",
                      ),
                    ),
                    onTap: () => launchUrl(Uri.parse("https://t.me/mytokuzbot"!)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          else if(index == 3){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Profile()));
          }
          else if(index == 0){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        letIndexChange: (index) => true,
      ),
    );

  }
}
