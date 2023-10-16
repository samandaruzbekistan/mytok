import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mytok/firebase_api.dart';
import 'package:mytok/screens/sms_code.dart';
import 'package:mytok/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  late Color myColor;
  var box = Hive.box('users');
  late Size mediaSize;
  String? selectedValue = null;
  String? selectedRegionName = null;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final random = Random();
  bool _isLoading = false;
  bool isObscure = true;
  List<Map<String, dynamic>> regions = [];
  List<DropdownMenuItem<String>> dropdownItems = [];


  void _toggle() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  void fetchDataFromApi() {
    http.post(Uri.parse('https://mytok.uz/flutterapi/getregion.php')).then((response) {
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json.decode(response.body));
        setState(() {
          regions = data;
          dropdownItems = data.map((item) {
            return DropdownMenuItem<String>(
              child: Text(item['region']),
              value: item['id'].toString(),
            );
          }).toList();
        });
      } else {
        _internetError(context);
      }
    }).catchError((error) {
      _internetError(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.yellow,
        image: DecorationImage(
          image: const AssetImage("assets/images/logo.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.yellow,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage('assets/images/logo.png'),
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: AppColors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Map<String, dynamic> findRegionById(String id) {
    Map<String, dynamic> region = regions.firstWhere((region) => region['id'] == id, orElse: () => Map<String, dynamic>.from({}));
    return region;
  }


  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Xush kelibsiz!",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.w500),
        ),
        // _buildGreyText("MyTok tezkor va sifatli xizmat"),
        const SizedBox(height: 35),
        _buildGreyText("Ism familya"),
        _buildNameInputField(nameController),
        const SizedBox(height: 20),
        _buildGreyText("Telefon"),
        _buildPhoneInputField(phoneController),
        const SizedBox(height: 20),
        _buildGreyText("Parol"),
        _buildPasswordInputField(passwordController, isObscure),
        const SizedBox(height: 20),
        _buildGreyText("Hudud"),
        DropdownButtonFormField(
            validator: (value) => value == null ? "Select a country" : null,
            // dropdownColor: Colors.blueAccent,
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
                selectedRegionName = dropdownItems
                    .firstWhere((item) => item.value == newValue)
                    .child
                    .toString();
              });
            },
            items: dropdownItems),
        const SizedBox(height: 40),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildPasswordInputField(TextEditingController controller, isObscure) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.remove_red_eye : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _toggle();
            });
          },
        ),
      ),
      obscureText: isObscure,
    );
  }

  Widget _buildPhoneInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.phone),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildNameInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? Icon(Icons.remove_red_eye)
            : Icon(Icons.account_circle_outlined),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        var region_ = findRegionById(selectedValue!);
        final connectivityResult = await (Connectivity().checkConnectivity());
        if ((phoneController.text.length == 12) &&
            (phoneController.text.startsWith("998"))) {
          if (passwordController.text.length > 7) {
            if (connectivityResult != ConnectivityResult.none) {
              var request = http.MultipartRequest('POST',
                  Uri.parse('https://mytok.uz/API/checkphonenumber.php'));
              request.fields.addAll({'phonenumber': '${phoneController.text}'});
              setState(() {
                _isLoading = true;
              });
              http.StreamedResponse response = await request.send();
              if (response.statusCode == 200) {
                var res = await response.stream.bytesToString();
                Map valueMap = json.decode(res);
                if (valueMap['registered'] == false) {
                  box.put('temp_name', nameController.text);
                  box.put('temp_phone', phoneController.text);
                  box.put('temp_password', passwordController.text);
                  box.put('temp_region_id', selectedValue);
                  box.put('temp_region_name', region_['region']);
                  final sixDigitNumber = random.nextInt(900000) + 100000;
                  var request2 = http.MultipartRequest('POST',
                      Uri.parse('https://mytok.uz/flutterapi/sendsms.php'));
                  request2.fields.addAll({
                    'phone': '${phoneController.text}',
                    'code': '${sixDigitNumber}'
                  });
                  http.StreamedResponse response2 = await request2.send();
                  if (response2.statusCode == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SmsCode(code: '${sixDigitNumber}'),
                      ),
                    );
                  } else {
                    setState(() {
                      _isLoading = false;
                    });
                    _apiError(context);
                  }
                } else if (valueMap['registered'] == true) {
                  setState(() {
                    _isLoading = false;
                  });
                  _loginError(context);
                }
              } else {
                setState(() {
                  _isLoading = false;
                });
                _apiError(context);
              }
            } else {
              _internetError(context);
            }
          } else {
            _passwordError(context);
          }
        } else {
          _onBasicAlertPressedValidate(context);
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: AppColors.black,
        minimumSize: const Size.fromHeight(60),
      ),
      child: _isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : const Text(
              "Ro'yhatdan o'tish",
              style: TextStyle(color: AppColors.white),
            ),
    );
  }
}

_onBasicAlertPressedValidate(context) {
  Alert(
    context: context,
    type: AlertType.info,
    title: "Xatolik!",
    desc: "Telefon raqamni quidagicha kiriting:\n998XXXXXXXXX",
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

_loginError(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik!",
    desc: "Raqam ro'yhatdan o'tgan",
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

_passwordError(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik!",
    desc: "Parol kamida 8 ta belgi bo'lishi kerak",
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

