import 'package:flutter/material.dart';
import 'package:mytok/screens/success_page/widgets/lottie_widget.dart';
import 'package:mytok/screens/success_page/widgets/ok_button.dart';
import 'package:mytok/screens/success_page/widgets/router_text.dart';

import '../sizeConfig.dart';

class CheckCart extends StatelessWidget {
  const CheckCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: [
            SizedBox(height: h*0.15,),
            LottieWidget(),
            RouterText(),
            // SizedBox(height: h*0.05,),
            OkButton(),
          ]
      ),
    );
  }
}