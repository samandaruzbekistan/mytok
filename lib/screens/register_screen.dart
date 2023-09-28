import 'package:flutter/material.dart';
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
  late Size mediaSize;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool rememberUser = false;


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
        _buildInputField(phoneController),
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

  Widget _buildNameInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.account_circle_outlined),
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
        final firebaseApi = FirebaseApi();
        final fcmToken = await firebaseApi.getFCMToken();
        var request = http.MultipartRequest('POST', Uri.parse('https://metest.uz/API/'));
        request.fields.addAll({
          'username': 'YOUR-NAME',
          'phonenumber': 'YOUR-PHONE-NUMBER',
          'fmctoken': 'YOUR-FMS-TOKEN',
          'password': 'YOUR-PASSWORD'
        });


        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
        }
        else {
          print(response.reasonPhrase);
        }
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const SmsCode()));
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: AppColors.black,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "RO'YHATDAN O'TISH",
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
