import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstname;
  String? secondname;
  String? email;
  String? password;
  int? phonenumber;
  String? place;
  int? age;

  UserModel({
    this.id,
    this.firstname,
    this.secondname,
    this.email,
    this.password,
    this.phonenumber,
    this.place,
    this.age
    
  });

  factory UserModel.fromMap(DocumentSnapshot map){

    return  UserModel(
      id: map.id,
      firstname: map["firstname"],
      secondname: map["secondname"],
      email: map["email"],
      password: map["password"],
      phonenumber: map["phonenumber"],
      place: map["place"],
      age: map["age"]
    );
  }

  Map<String,dynamic>toMap(){
    return {
      "firstname":firstname,
      "secondname":secondname,
      "email":email,
      "password":password,
      "phonenumber":phonenumber,
      "place":place,
      "age":age





    };
  }


  
}