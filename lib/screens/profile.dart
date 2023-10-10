import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mytok/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'contact.dart';
import 'orders.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    var box = Hive.box('users');
    var name = "${box.get("phone")}";
    TextEditingController nameController = TextEditingController()
      ..text = "${box.get('name')}";
    TextEditingController phoneController = TextEditingController()
      ..text = "${box.get('phone')}";


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Profil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(w * 0.1),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/profile.png", width: w * 0.4),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    label: const Text("F.I.Sh"),
                    suffixIcon: const Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey))),
              ),
              const SizedBox(
                height: 18,
              ),
              TextField(
                controller: phoneController,
                readOnly: true,
                decoration: InputDecoration(
                    label: const Text("Telefon"),
                    suffixIcon: const Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey))),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if ((phoneController.text.length == 12) &&
                        (phoneController.text.startsWith("998"))) {
                      if (connectivityResult != ConnectivityResult.none) {
                        var request = http.MultipartRequest(
                            'POST',
                            Uri.parse(
                                'https://metest.uz/API/updateuserdata.php'));
                        request.fields.addAll({
                          'phonenumber': '${phoneController.text}',
                          'username': '${nameController.text}',
                          'userid': '${box.get('id')}'
                        });
                        setState(() {
                          _isLoading = true;
                        });
                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          var res = await response.stream.bytesToString();
                          Map valueMap = json.decode(res);
                          setState(() {
                            _isLoading = false;
                          });
                          box.put('name', nameController.text);
                          _onBasicAlertSuccess(context);
                          // box.put('phone', phoneController.text);
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          _apiError(context);
                        }
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        _internetError(context);
                      }
                    } else {
                      _onBasicAlertPressedValidatePhone(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 10)),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.black)
                      : const Text(
                    "Yangilash",
                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                // width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    box.clear();
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      elevation: 0,
                      foregroundColor: Colors.red,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10)),
                  child: const Text(
                    "Chiqish",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 3,
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
          else if(index == 0){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

_onBasicAlertPressedValidatePhone(context) {
  Alert(
    context: context,
    type: AlertType.info,
    title: "Xatolik!",
    desc: "Telefon raqamni quidagicha kiriting:\n998 XX XXX XX XX",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () => Navigator.pop(context),
        color: AppColors.black,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}


_onBasicAlertSuccess(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Xabar!",
    desc: "Sizning malumotlaringiz o'zgartirildi",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () => Navigator.pop(context),
        color: AppColors.black,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

_internetError(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Xatolik!",
    desc: "Internetga ulanmagansiz",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () => Navigator.pop(context),
        color: AppColors.black,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

_apiError(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Xatolik!",
    desc: "API da nosozlik",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () => Navigator.pop(context),
        color: AppColors.black,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}
