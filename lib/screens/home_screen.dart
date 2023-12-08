import 'dart:ffi';

// import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mytok/screens/contact.dart';
import 'package:mytok/screens/electr_categories.dart';
import 'package:mytok/screens/handyman_categories.dart';
import 'package:mytok/screens/orders.dart';
import 'package:mytok/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mytok/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'package:video_player/video_player.dart';

// import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  var box = Hive.box('users');
  bool isLoading = true;
  List<dynamic> adData = [];
  List<dynamic> data = [];
  bool type = false;
  late VideoPlayerController _controller;



  @override
  void initState() {
    super.initState();
    _loadAdData();
  }

  void playVideo(String link){
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://manager.mytok.uz/admin/dashboard/controller/social_files/'+link))
      ..initialize().then((_) {

        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    print('http://manager.mytok.uz/admin/dashboard/controller/social_files/'+link);
    _controller.play();
    _controller.setVolume(0);
    _controller.setLooping(true);
  }

  Future<void> _loadAdData() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      setState(() {
        isLoading = false;
      });
      return;
    }

    // Fetch ad data from API
    final apiUrl =
        'https://mytok.uz/API/select_social.php'; // Replace with your API URL
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successful API request
        data = json.decode(response.body);
        if(data.isNotEmpty){
          if (data[0]['type'] == "video") {
            setState(() {
              // _initializeVideoPlayer(data[0]['file_link']);
              playVideo(data[0]['file_link']);
              type = true;
              adData = data;
              isLoading = false;
              ;
            });
          } else {
            setState(() {
              type = false;
              adData = data;
              isLoading = false;
            });
          }
        }
      } else {
        // Handle API error
        setState(() {
          isLoading = false;
        });
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle general error
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var region_name = box.get('region_name');

    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Image.asset("assets/images/logo.png"),
                      width: 40,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 18),
                        Text(
                          '${region_name}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                isLoading
                    ? Text(
                        "Xizmatlar") // Show a loading indicator when data is loading
                    : InkWell(
                        onTap: () {
                          print(adData);
                          launchUrl(Uri.parse(adData[0]['text']));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.symmetric(
                          //     vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFF5F3FF),
                          ),
                          child: type?
                                _controller.value.isInitialized
                                ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                                )
                                    : Container()

                              : Image.network(
                                  "https://manager.mytok.uz/admin/dashboard/controller/social_files/" +
                                      "${adData[0]['file_link']}"),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const TextLocation()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ElectrCategories()));
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFF5F3FF)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: Image.asset("assets/images/electr.png"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Elektr ishlari",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // _alert(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HandymanCategories()));
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFF5F3FF)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: Image.asset("assets/images/plumbing.png"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Santexnika ishlari",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: h * 0.08,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.history, size: 30),
          Icon(Icons.phone, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.yellow,
        buttonBackgroundColor: Colors.yellow,
        backgroundColor: Colors.white,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyOrders()));
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ContactScreen()));
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        letIndexChange: (index) => true,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   showUnselectedLabels: true,
      //   iconSize: 25,
      //   selectedItemColor: AppColors.black,
      //   selectedFontSize: 18,
      //   currentIndex: 0,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (index) {
      //     // Handle navigation based on the tapped index
      //     switch (index) {
      //       case 1:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => MyOrders()));
      //
      //         break;
      //       case 3:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const Profile()));
      //       case 2:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const CheckCart()));
      //
      //         break;
      //       default:
      //         // Do nothing
      //         break;
      //     }
      //   },
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: "Tarix"),
      //     BottomNavigationBarItem(icon: Icon(Icons.call), label: "Bog'lanish"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label: "Profil"),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

_alert(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Xabar!",
    desc: "Bo'lim tez kunda ishga tushadi",
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
