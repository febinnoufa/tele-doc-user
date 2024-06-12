import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstname;
  String? lastdname;
  String? email;
  String? password;
  String? profile;
  int? phonenumber;
  String? place;
  int? age;
  String? address;

  UserModel(
      {this.id,
      this.firstname,
      this.lastdname,
      this.email,
      this.password,
      this.phonenumber,
      this.profile,
      this.place,
      this.age,
      this.address});

  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
        id: map.id,
        firstname: map["firstname"],
        lastdname: map["lastdname"],
        email: map["email"],
        password: map["password"],
        profile: map['profile'],
        phonenumber: map["phonenumber"],
        place: map["place"],
        age: map["age"],
        address: map["address"]);
  }

  Map<String, dynamic> toMap() {
    return {
      // "id":id,
      "firstname": firstname,
      "lastdname": lastdname,
      "email": email,
      "password": password,
      'profile':profile,
      "phonenumber": phonenumber,
      "place": place,
      "age": age,
      "address": address
    };
  }
}
