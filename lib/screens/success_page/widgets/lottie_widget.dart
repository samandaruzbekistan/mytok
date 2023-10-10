import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../sizeConfig.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Center(
        child: Lottie.network(
            "https://assets8.lottiefiles.com/packages/lf20_jz2wa00k.json",
            // height: h*0.2,    /// 300
            width: w*0.7,      /// 300
            repeat: false
        ),
    );
  }
}
