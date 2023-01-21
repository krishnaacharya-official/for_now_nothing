class UserModel {
  final String avatar;
  final String fullName;
  final String phoneNumber;
  final String dob;
  final String email;
  String? id;

  UserModel(
      {required this.avatar,
      required this.dob,
      required this.email,
      required this.fullName,
      required this.phoneNumber});

  factory UserModel.fromjson(Map<String, dynamic> json, String id) {
    return UserModel(
        avatar: json['avatar'],
        dob: json["dob"],
        email: json['email'],
        fullName: json['fullName'],
        phoneNumber: json['phoneNumber']);
  }
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'dob': dob,
      'avatar': avatar,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "avatar $avatar \n fullName $fullName \n dob $dob \n email $email\n phone $phoneNumber ";
  }
}
