import 'package:flutter/material.dart';
import 'package:mytok/screens/register_screen.dart';
import 'package:mytok/utils/colors.dart';

import '../screens/sizeConfig.dart';

class RegisterButtonWidget extends StatefulWidget {
  const RegisterButtonWidget({Key? key}) : super(key: key);

  @override
  _RegisterButtonWidgetState createState() => _RegisterButtonWidgetState();
}

class _RegisterButtonWidgetState extends State<RegisterButtonWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth!/20.55,
          0,
          SizeConfig.screenWidth!/20.55,
          SizeConfig.screenHeight!/34.15
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.registerColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(SizeConfig.screenWidth!/1.37, SizeConfig.screenHeight!/13.66)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegPage()));
          },
          child: Text(
            "SIGNUP",
            style: TextStyle(color: AppColors.buttonColor, fontSize: SizeConfig.screenHeight!/42.69,  fontWeight: FontWeight.w700),   /// 16
          ),
        ),
      ),
    );
  }
}
