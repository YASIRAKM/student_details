import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_details/controller/student_controller.dart';
import 'package:student_details/utils/constants/themes/app_color.dart';
import 'package:student_details/utils/constants/validators.dart';
import 'package:student_details/utils/widgets/new_text_form_field.dart';


import '../utils/widgets/new_elevated_button.dart';

class StudentAdd extends StatelessWidget {
  const StudentAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return  Consumer<StudentController>(
                builder: (context, studentController, child) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                      studentController.nameController.clear();
                      studentController.ageController.clear();
                      studentController.imageLink= '';
                    },
                    child: const Icon(Icons.person)),
                appBar: AppBar(automaticallyImplyLeading: false,title: const Text("ADD STUDENT")),
                body: Form(key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: wt * .1,
                        right: wt * .1,
                        top: ht * .12,
                        bottom: ht * .15),
                    child: ListView(
                      children: [
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: ht * .4,
                                        bottom: ht * .3,
                                        left: wt * .1,
                                        right: wt * .1),
                                    child: Card(elevation: 5,
                                      color: AppColor.bodyColor,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(wt * .02),
                                            border: Border.all(
                                                color: AppColor.buttonBackgroundColor,
                                                width: 5)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: ht * .03,
                                            ),
                                            NewElevatedButtonWidget(
                                              onPressed: () {
                                                studentController.cameraImage();
                                              },
                                              buttonText: 'Camera',
                                              dark: false,
                                            ),
                                            SizedBox(height: ht * .05),
                                            NewElevatedButtonWidget(
                                              onPressed: () {
                                                studentController.galleryImage();
                                              },
                                              buttonText: 'Gallery',
                                              dark: false,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                                backgroundColor: AppColor.cardColor,
                                backgroundImage: studentController.imageLink!.isEmpty
                                    ? null
                                    : NetworkImage(
                                        studentController.imageLink.toString()),
                                radius: wt * .2,
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: AppColor.iconColor,
                                  size: ht * .1,
                                ))),
                        SizedBox(
                          height: ht * .05,
                        ),
                        NewTextFieldWidget(
                          keyBoardType: TextInputType.text,
                          controller: studentController.nameController,
                          iconData: Icons.person,
                          labelText: 'Student name',
                          validator: MyValidator.validateName,
                          dark: false,
                        ),
                        SizedBox(
                          height: ht * .05,
                        ),
                        NewTextFieldWidget(
                          keyBoardType: TextInputType.number,
                          controller: studentController.ageController,
                          iconData: CupertinoIcons.number_square_fill,
                          labelText: 'Age',
                          validator: MyValidator.validateAge,
                          dark: false,
                        ),
                        SizedBox(
                          height: ht * .05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: wt * .15, right: wt * .15),
                          child: NewElevatedButtonWidget(
                            onPressed: () async {
                              final url = await SharedPreferences.getInstance();
                              final imageUrl = url.getString('url');

                              if (formKey.currentState!.validate()) {
                                if (imageUrl!.isNotEmpty) {
                                  studentController.uploadFirebase({
                                    "name": studentController.nameController.text,
                                    "age": int.parse(
                                        studentController.ageController.text),
                                    "imageUrl": imageUrl
                                  });
                                }
                              }
                              studentController.nameController.clear();
                              studentController.ageController.clear();
                              url.setString("url", "");
                            },
                            buttonText: 'Add Student',
                            dark: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })

    ;
  }
}
