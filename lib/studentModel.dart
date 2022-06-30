

import 'inputPage.dart';

class Student {
  int id;
  String firstName;
  String lastName;
  String cityName;
  String collegeName;
  String address;
  String character;
  DateTime dob;
  List<dynamic> subjects;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.cityName,
    required this.collegeName,
    required this.address,
    required this.character,
    required this.dob,
    required this.subjects,
  });

  // Student.fromJson(Map<String, Object?> json)
  //     : this(
  //   id: json["id"]! as int,
  //   firstName: json["firstName"]! as String,
  //   lastName: json["lastName"]! as String,
  //   cityName: json["cityName"]! as String,
  //   collegeName: json["collegeName"]! as String,
  //   address: json["address"]! as String,
  // );

  // factory Student.fromMap(Map<String, dynamic> json) => Student(
  //   id: json["id"] ,
  //   firstName: json["firstName"] ?? "",
  //   lastName: json["lastName"] ?? "",
  //   cityName: json["cityName"] ?? "",
  //   collegeName: json["collegeName"] ?? "",
  //   address: json["address"],
  // );

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "cityName": cityName,
      "collegeName": collegeName,
      "address": address,
      "gender": character,
      "dateOfBirth": dob,
      "subjects": subjects,
    };
  }
}

  // factory Student.fromMap(Map<String, dynamic> json) => Student(
  //   id: json["id"] ,
  //   firstName: json["firstName"] ?? "",
  //   lastName: json["lastName"] ?? "",
  //   cityName: json["cityName"] ?? "",
  //   collegeName: json["collegeName"] ?? "",
  //   address: json["address"],
  // );
  //
  // Map<String, dynamic> toMap() => {
  //   "id": id,
  //   "firstName": firstName,
  //   "lastName": lastName,
  //   "cityName": cityName,
  //   "collegeName": collegeName,
  //   "address": address,
  //};