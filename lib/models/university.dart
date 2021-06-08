import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'majors.dart';

class University {
  final String imageUrl;
  final List<Majors> listMajors;
  final String formsOfTraining;
  final String name;
  final String idUniversity;
  final double minTuition;
  final double maxTuition;
  final String location;
  final String universityType;
  final String universityUrl;
  final String? id;

  bool isNationalUniversity;
  double rate;

  University({
    this.id,
    required this.name,
    required this.imageUrl,
    this.rate = 10,
    required this.formsOfTraining,
    required this.idUniversity,
    required this.isNationalUniversity,
    required this.listMajors,
    required this.location,
    required this.maxTuition,
    required this.minTuition,
    required this.universityType,
    required this.universityUrl,
  });
  static List keyWord(String name) {
    name = name.capitalize!;
    List list = [];
    String temp = "";
    String temp2 = "";
    int count = 0;
    String temp3 = "";

    for (var i = 0; i < name.length; i++) {
      temp = temp + name[i];
      list.add(temp);
      if (count >= 2) {
        temp3 = temp3 + name[i];
        list.add(temp3);
        if (name[i] == " ") {
          temp2 = '';
        } else {
          temp2 = temp2 + name[i];
          list.add(temp2);
        }
      }
      if (name[i] == " ") count++;
    }
    return list;
  }

  factory University.fromMap(Map<String, dynamic> mapData) {
    return University(
      name: mapData['name'],
      imageUrl: mapData['imageUrl'],
      formsOfTraining: mapData['formsOfTraining'],
      idUniversity: mapData['idUniversity'],
      isNationalUniversity: mapData['isNationalUniversity'],
      listMajors: mapData['listMajors'],
      location: mapData['location'],
      maxTuition: mapData['maxTuition'].toDouble(),
      minTuition: mapData['minTuition'].toDouble(),
      universityType: mapData['universityType'],
      universityUrl: mapData['universityUrl'],
    );
  }

  factory University.fromJson(dynamic jsonData) {
    return University(
      name: jsonData['name'],
      imageUrl: jsonData['imageUrl'],
      formsOfTraining: jsonData['formsOfTraining'],
      idUniversity: jsonData['idUniversity'],
      isNationalUniversity: jsonData['isNationalUniversity'],
      listMajors: List<Majors>.from(
          jsonData['listMajors'].map((i) => Majors.fromJson(i))),
      location: jsonData['location'],
      maxTuition: jsonData['maxTuition'].toDouble(),
      minTuition: jsonData['minTuition'].toDouble(),
      universityType: jsonData['universityType'],
      universityUrl: jsonData['universityUrl'],
      id: jsonData.id,
    );
  }

  static fromDatabase(List<dynamic> listData) {
    return List<University>.from(
        listData.map((jsonData) => University.fromJson(jsonData)));
  }

  static Map<String, dynamic> toMap(University university) {
    final mapMajors = university.listMajors
        .map((majors) => {
              'nameMajors': majors.name,
              'idMajors': majors.idMajors,
              'studyTime': majors.studyTime,
              'grade': majors.grade,
            })
        .toList();
    final mapData = {
      'name': university.name,
      'imageUrl': university.imageUrl,
      'formsOfTraining': university.formsOfTraining,
      'idUniversity': university.idUniversity,
      'isNationalUniversity': university.isNationalUniversity,
      'listMajors': mapMajors,
      'location': university.location,
      'maxTuition': university.maxTuition,
      'minTuition': university.minTuition,
      'universityType': university.universityType,
      'universityUrl': university.universityUrl,
      'rate': university.rate,
      'keyword': keyWord(university.name),
    };
    return mapData;
  }

  static toDataBase(University university) async {
    final data = toMap(university);
    await FirebaseFirestore.instance.collection('ListUniversity').add(data);
    print('Done');
  }
}
