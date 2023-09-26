


class User {
  final int id;
  final String fullname;
  final String phone;

  static const String TABLE_NAME="users";
  User({required this.id, required this.fullname, required this.phone});

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "fullname":fullname,
      "phone":phone
    };
  }
}
