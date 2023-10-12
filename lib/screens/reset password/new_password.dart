import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/login_screen.dart';
import 'package:mytok/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';



class NewPassword extends StatefulWidget {
  const NewPassword({super.key});



  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();

  var box = Hive.box('users');
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
            height: 200,
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
          "Yangi parol",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.w500),
        ),
        // _buildGreyText("MyTok tezkor va sifatli xizmat"),
        const SizedBox(height: 60),
        _buildGreyText("Kamida 8 ta belgidan iborat bo'lsin"),
        _buildNameInputField(emailController),

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

  Widget _buildNameInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      // keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? Icon(Icons.remove_red_eye)
            : Icon(Icons.password_outlined),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (emailController.text.length > 7) {
          setState(() {
            _isLoading = true;
          });
          var request = http.MultipartRequest(
              'POST', Uri.parse('https://mytok.uz/API/updatepassword.php'));
          request.fields.addAll({
            'phonenumber': '${box.get("temp_phone")}',
            'password': '${emailController.text}'
          });
          http.StreamedResponse response = await request.send();
          if (response.statusCode == 200) {
            var res = await response.stream.bytesToString();
            Map valueMap = json.decode(res);
            if(valueMap['message'] == "Yangilanish muvaffaqiyatli"){
              _passwordUpdated(context);
            }
            else{
              setState(() {
                _isLoading = false;
              });
              _apiError(context);
            }
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
          _passwordError(context);
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
        "YANGILASH",
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

_passwordError(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Xatolik!",
    desc: "Parol kamida 8 ta belgi bo'lsin",
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


_passwordUpdated(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Xabar!",
    desc: "Parolingiz yangilandi",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage())),
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
