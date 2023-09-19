// ignore_for_file: non_constant_identifier_names

class UserModel {
  String ownername;
  String shopname;
  String address;
  String phoneNumber;
  String uid;
  String createdAt;
  String city;

  UserModel({
    required this.ownername,
    required this.shopname,
    required this.address,
    required this.phoneNumber,
    required this.uid,
    required this.createdAt,
    required this.city,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      ownername: map['owner name']??'',
      shopname: map['shop name']??'',
      address: map['address']??'',
      uid: map['uid'] ?? '',
      phoneNumber: map['phone Number'] ?? '',
      createdAt :map['createdAt']??'',
      city: map['city']??'',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "owner name":ownername,
      "shop name":shopname,
      "address":address,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "created At":createdAt,
      "city":city,
    };
  }
}
