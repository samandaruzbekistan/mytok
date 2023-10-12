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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool rememberUser = false;
  final random = Random();
  bool _isLoading = false;

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
        const SizedBox(height: 60),
        _buildGreyText("Ism familya"),
        _buildNameInputField(nameController),
        const SizedBox(height: 20),
        _buildGreyText("Telefon"),
        _buildPhoneInputField(phoneController),
        const SizedBox(height: 20),
        _buildGreyText("Parol"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 40),
        // _buildRememberForgot(),
        // const SizedBox(height: 20),
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

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.phone),
      ),
      obscureText: isPassword,
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

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {}, child: _buildGreyText("Parol esingizda yo'qmi?"))
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if ((phoneController.text.length == 12) &&
            (phoneController.text.startsWith("998"))) {
          if(passwordController.text.length > 7){
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
                  final sixDigitNumber = random.nextInt(900000) + 100000;
                  var request2 = http.MultipartRequest('POST',
                      Uri.parse('https://markaz.ideal-study.uz/api/sendSms'));
                  request2.fields.addAll({
                    'phone': '${phoneController.text}',
                    'code': '${sixDigitNumber}'
                  });
                  http.StreamedResponse response2 = await request2.send();
                  if (response2.statusCode == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SmsCode(code: '${sixDigitNumber}'),
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
          }
          else{
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

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/facebook.png")),
              Tab(icon: Image.asset("assets/images/twitter.png")),
              Tab(icon: Image.asset("assets/images/github.png")),
            ],
          )
        ],
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
