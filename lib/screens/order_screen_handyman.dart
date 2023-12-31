import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:mytok/screens/orders.dart';
import 'package:mytok/screens/success_page/success_page_view.dart';
import 'package:mytok/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class OrderHandyman extends StatefulWidget {
  const OrderHandyman(
      {Key? key,
        required this.job_title,
        required this.avatar,
        required this.description})
      : super(key: key);
  final String job_title;
  final String avatar;
  final String description;


  @override
  State<OrderHandyman> createState() => _OrderHandymanState();
}

class _OrderHandymanState extends State<OrderHandyman> {
  var box = Hive.box('users');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late String lat;
  late String long;
  bool _isLoading = false;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
      });
      await _locationError(context);
      throw Exception("Location service is not enabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      setState(() {
        _isLoading = false;
      });
      await _locationError(context);
      throw Exception("Location permission denied");
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false;
      });
      await _locationError(context);
      throw Exception("Location permission denied forever");
    }

    return await Geolocator.getCurrentPosition();
  }



  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var phone = box.get('phone');
    var region_id = box.get('region_id');

    return Scaffold(
      appBar: AppBar(
        title: Text("Yangi buyurtma"),
        centerTitle: true,
        backgroundColor: AppColors.yellow,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
          EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.avatar,
                width: w * 0.2,
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Text(
                widget.job_title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Text(
                "Telefon",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "+${phone}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Text(
                "Joylashuv",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "Joriy joylashuv",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final connectivityResult =
                  await (Connectivity().checkConnectivity());
                  if (connectivityResult != ConnectivityResult.none) {
                    final position = await _getCurrentLocation();
                    setState(() {
                      lat = '${position.latitude}';
                      long = '${position.longitude}';
                    });
                    var request = http.MultipartRequest('POST', Uri.parse('https://mytok.uz/API/saveorder.php'));
                    request.fields.addAll({
                      'type': '1',
                      'category': '${widget.job_title}',
                      'fullname': '${box.get('name')}',
                      'phonenumber': '${phone}',
                      'userid': '${box.get('id')}',
                      'jobid': '0',
                      'lat': lat,
                      'long': long,
                      'region_id': '${region_id}',
                    });

                    http.StreamedResponse response = await request.send();
                    if (response.statusCode == 200){
                      setState(() {
                        _isLoading = false;
                      });
                      var res = await response.stream.bytesToString();
                      Map valueMap = json.decode(res);
                      if (valueMap['success'] == true) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CheckCart()));
                      }
                      else if(valueMap['status'] == false){
                        _orderFound(context);
                      }
                    }
                  }
                  else {
                    _internetError(context);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  // shape: const StadiumBorder(),
                  // elevation: 20,
                  backgroundColor: AppColors.yellow,
                  minimumSize: const Size.fromHeight(60),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.black,
                )
                    : const Text(
                  "Yuborish",
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_formError(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Xatolik!",
    desc: "Maydon noto'g'ri to'ldirilgan",
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


Future<void> _locationError(context) async {
  await Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik!",
    desc: "Joylashuvni olish uchun ilovaga ruhsat zarur. Qayta urinib ko'ring",
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

_orderFound(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Ogoxlantirish!",
    desc: "Sizda buyurtmalar mavjud",
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