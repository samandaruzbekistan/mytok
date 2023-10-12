import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mytok/screens/reset%20password/reset_passsword_sms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../../utils/colors.dart';

class GetPhone extends StatefulWidget {
  const GetPhone({Key? key}) : super(key: key);

  @override
  State<GetPhone> createState() => _GetPhoneState();
}

class _GetPhoneState extends State<GetPhone> {
  late Color myColor;
  late Size mediaSize;
  var box = Hive.box('users');
  TextEditingController phoneController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
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
          "Parolni tiklash",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        // _buildGreyText("MyTok tezkor va sifatli xizmat"),
        const SizedBox(height: 60),
        _buildGreyText("Telefon raqamingiz"),
        _buildNameInputField(phoneController),

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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? Icon(Icons.remove_red_eye)
            : Icon(Icons.phone),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if ((phoneController.text.length == 12) &&
            (phoneController.text.startsWith("998"))){
          if (connectivityResult != ConnectivityResult.none) {
            box.put("temp_phone", phoneController.text);
            var request = http.MultipartRequest('POST', Uri.parse('https://mytok.uz/API/checkphonenumber.php'));
            request.fields.addAll({
              'phonenumber': '${phoneController.text}'
            });
            setState(() {
              _isLoading = true;
            });
            http.StreamedResponse response = await request.send();
            var res = await response.stream.bytesToString();
            if (response.statusCode == 200) {
              Map valueMap = json.decode(res);
              if (valueMap['registered'] == true){
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
                      builder: (context) => ResetPasswordSms(code: '${sixDigitNumber}'),
                    ),
                  );
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                  _apiError(context);
                }
              }
              else{
                _phoneError(context);
              }
            }
            else{
              _apiError(context);
            }
          }
          else{
            _internetError(context);
          }
        }
        else{
          _onBasicAlertPressedValidatePhone(context);
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
        "KIRITISH",
        style: TextStyle(color: AppColors.white),
      ),
    );
  }


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

_phoneError(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Xatolik!",
    desc: "Raqam ro'yhatdan o'tmagan",
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
