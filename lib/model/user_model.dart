import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String password;
  String name;
  String photo;
  String hospitalName;
  String dob;

  UserModel(
      {required this.uid,
      required this.email,
      required this.password,
      required this.photo,
      required this.dob,
      required this.hospitalName,
      required this.name});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'email': email,
        'password': password,
        'dob': dob,
        'hospitalName': hospitalName,
        'photo': photo
      };

  ///
  static UserModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return UserModel(
      name: snapshot['name'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photo: snapshot['photo'],
      password: snapshot['password'],
      dob: snapshot['dob'],
      hospitalName: snapshot['hospitalName'],
    );
  }
}
