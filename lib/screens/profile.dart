import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/welcome_screen.dart';
import 'package:mytok/utils/colors.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var box = Hive.box('users');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Profil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(w * 0.1),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/profile.png", width: w * 0.4),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                initialValue: box.get("name"),
                decoration: InputDecoration(
                    label: const Text("F.I.Sh"),
                    suffixIcon: const Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(width: 2, color: Colors.grey)
                    )
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              TextFormField(
                initialValue: box.get("phone"),
                decoration: InputDecoration(
                    label: const Text("Telefon"),
                    suffixIcon: const Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(width: 2, color: Colors.grey)
                    )
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 10)
                  ),
                  child: const Text("Yangilash", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize:20),),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                // width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    box.clear();
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      elevation: 0,
                      foregroundColor: Colors.red,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                  ),
                  child: const Text("Chiqish", style: TextStyle(fontSize:20),),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 25,
        selectedItemColor: AppColors.black,
        selectedFontSize: 18,
        currentIndex: 3,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation based on the tapped index
          switch (index) {
            case 1:
            // Navigate to HomeScreen

              break;
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()));

              break;
            default:
            // Do nothing
              break;
          }
        },
        items:const  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Tarix"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Bog'lanish"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
