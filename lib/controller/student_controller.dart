
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_details/model/stuent_model.dart';

class StudentController extends ChangeNotifier {
  File? imageFile;
  UploadTask? uploadTask;
 String?  imageLink="";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<StudentModel> studentList = [];
  List<StudentModel> filteredList = [];
  RangeValues ageRange = const RangeValues(5, 30);

  TextEditingController get nameController => _nameController;

  TextEditingController get ageController => _ageController;

  StudentController() {
    fetchData(null);
  }

  fetchData(String? keyword) async {

    if (keyword == null) {
      final response =
      await FirebaseFirestore.instance.collection('Student').get();
      studentList =
          response.docs.map((e) => StudentModel.fromJson(e.data())).toList();
      filteredList = studentList;

    } else {
      filteredList = studentList
          .where((element) =>
              element.name!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }
   filterByAge(){
    if(ageRange.start == 0 ){
      filteredList = studentList;
    }
    else{
    filteredList = studentList.where((student){
      return student.age! >= ageRange.start && student.age! <= ageRange.end;
    } ).toList();
    }
    notifyListeners();
   }
  void updateAgeRange(RangeValues newRange) {
    ageRange = newRange;
    notifyListeners();
  }

  uploadFirebase(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection("Student").add(data);
    Fluttertoast.showToast(msg: "STUDENT ADDED SUCCESSFULLY");
  }

  cameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    imageFile = File(image!.path);
    var imPath = File(imageFile!.path);
    var ref = await FirebaseStorage.instance.ref().child("Image/$imPath");
    uploadTask = ref.putFile(imPath);
    final cmp = await uploadTask!.whenComplete(() {});
    var url = await cmp.ref.getDownloadURL();
    final db = await SharedPreferences.getInstance();
    await db.setString('url', url);
    imageLink =  db.getString("url");
    Fluttertoast.showToast(msg: "Image added successfully");


    notifyListeners();
  }

  galleryImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(image!.path);
    var imPath = File(imageFile!.path);
    var ref = await FirebaseStorage.instance.ref().child("Image/$imPath");
    uploadTask = ref.putFile(imPath);
    final cmp = await uploadTask!.whenComplete(() {});
    var url = await cmp.ref.getDownloadURL();
    final db = await SharedPreferences.getInstance();
    await db.setString('url', url);
    imageLink =  db.getString("url");
    Fluttertoast.showToast(msg: "Image added successfully");
    notifyListeners();
  }
}
