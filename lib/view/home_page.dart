import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/auth_controller.dart';
import 'package:student_details/controller/student_controller.dart';
import 'package:student_details/utils/constants/themes/app_color.dart';
import 'package:student_details/utils/constants/themes/app_text_styles.dart';
import 'student_add.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Consumer2<StudentController, AuthController>(
          builder: (context, studentController, authController, child) {
        return Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
          appBar: AppBar(
            title: const Text("STUDENT LIST"),
            actions: [
              IconButton(
                  onPressed: () {
                    authController.signOut(context);
                  },
                  icon: Icon(Icons.logout,color: AppColor.iconColor,))
            ],
          ),
          floatingActionButton: FloatingActionButton(elevation: 10,
              onPressed: () async {
                await Navigator.pushNamed(context, '/studAdd');
                studentController.fetchData(null);
              },
              child: const Icon(Icons.add,size: 40,)),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: wt * .05, right: wt * .05, top: ht * .02),
                child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(ht*.1),border: Border.all(color:AppColor.iconColor ) ) ,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.iconColor,
                        ),
                        hintStyle: AppTextStyles.smallText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ht * .1),
                            borderSide:
                                BorderSide(color: AppColor.iconColor, width: 10)),
                        hintText: 'Search'),
                    onChanged: (value) {
                      if (value == '' || value == ' ') {
                        studentController.fetchData(null);
                      } else {
                        studentController.fetchData(value);
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: wt * .1),
                child: SizedBox(
                  width: wt * .9,
                  child: Row(
                    children: [
                      const Icon(Icons.sort),
                      Text(
                        "AGE (${studentController.ageRange.start.toInt()} -- ${studentController.ageRange.end.toInt()} )",
                        style: AppTextStyles.smallText,
                      ),
                      RangeSlider(
                        divisions: 50,
                        activeColor: Colors.teal,
                        labels: RangeLabels(
                            "Age :${studentController.ageRange.start.toInt()}",
                            "Age: ${studentController.ageRange.end.toInt()}"),
                        mouseCursor: MaterialStateMouseCursor.clickable,
                        values: studentController.ageRange,
                        min: 0,
                        max: 50,
                        onChanged: (value) {
                          studentController.updateAgeRange(value);
                        },
                        onChangeEnd: (value) {
                          studentController.filterByAge();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              studentController.filteredList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only( top: ht * .3),
                      child: InkWell(
                          onDoubleTap: () {
                            Navigator.pushNamed(context, '/studAdd');

                          },
                          child: Column(
                            children: [
                              CircularProgressIndicator(color: AppColor.iconColor),
                              SizedBox(height: ht*.05,),
                              SizedBox(width:wt*.25,child: Text("ADD STUDENT",style: AppTextStyles.labelText,))
                            ],
                          )),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: studentController.filteredList.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 0,
                          margin: EdgeInsets.only(
                              left: wt * .1, right: wt * .1, top: ht * .02),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ht * .005, bottom: ht * .01),
                            child: ListTile(
                              leading: Padding(
                                padding:  EdgeInsets.only(top: ht*.01),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: ht*.08,width: wt*.13,
                                    imageUrl: studentController
                                            .filteredList[index].imageUrl ??
                                        'n/a',
                                    placeholder: (context, url) =>const  CircularProgressIndicator(), // Display a placeholder while loading.
                                    errorWidget: (context, url, error) =>const CircleAvatar(child:  Icon(Icons.error)),
                                  ),
                                ),
                              ),
                              title: SizedBox(
                                height: ht * .05,
                                child: Text(
                                  studentController.filteredList[index].name ??
                                      'n/a',
                                  style: AppTextStyles.homeNameText,
                                ),
                              ),
                              subtitle: Text(
                                  'AGE: ${studentController.filteredList[index].age.toString()}',
                                  style: AppTextStyles.homeAgeText),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
