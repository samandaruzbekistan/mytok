import 'package:flutter/material.dart';
import 'package:mytok/screens/electr_categories.dart';
import 'package:mytok/screens/register_screen.dart';
import 'package:mytok/screens/web_socket_test.dart';
import 'package:mytok/utils/colors.dart';
import 'reg_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  AppColors.yellow,
                  AppColors.yellow,
                ]
            )
        ),
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Image(image: AssetImage('assets/images/logo.png'), width: 200),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text('Xush kelibsiz!',style: TextStyle(
                  fontSize: 30,
                  color: AppColors.black
              ),),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const ElectrCategories()));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.black),
                  ),
                  child: const Center(child: Text('Kirish',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black
                  ),),),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegPage()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('Ro\'yhatdan o\'tish',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black
                  ),),),
                ),
              ),
              const Spacer(),
              const Text('Version 1.0.0',style: TextStyle(
                  fontSize: 17,
                  color: AppColors.black
              ),),//
            ]
        ),
      ),

    );
  }
}