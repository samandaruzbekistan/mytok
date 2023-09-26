import 'package:flutter/material.dart';
import 'package:mytok/db/db_user.dart';

import '../users/user.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelperUser.instance.getUser().then((value) {
      setState(() {
        users.clear();
        users.addAll(value as Iterable<User>);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
