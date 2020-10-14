import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ------- my packages ---------------
import '../widgets/loadingWidget.dart';
import '../services/firestoreService.dart';
import '../models/set_up_model.dart';
import '../models/stateVariablesModel.dart';

class CourseSetUpWidget extends StatefulWidget {
  @override
  _CourseSetUpWidgetState createState() => _CourseSetUpWidgetState();
}

class _CourseSetUpWidgetState extends State<CourseSetUpWidget> {
  _addCourseFlagToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('courseFlag', true);
  }

  String course = "B.E.";
  String group = 'Civil';
  String sem = "I";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets pdTop = MediaQuery.of(context).padding;
    final cUser = Provider.of<User>(context);
    StateVariablesModel svm = Provider.of<StateVariablesModel>(context);
    final FirestoreService _fsService = new FirestoreService();
    return Scaffold(
        body: isLoading
            ? LoadingWidget()
            : Container(
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Color(0xffb2ff59),
                        Color(0xff69f0ae),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: pdTop.top,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: size.height * 0.085,
                        margin: const EdgeInsets.all(0),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          elevation: 10,
                          child: Center(
                            child: Text(
                              'Set Up Screen',
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: _fsService.fireStoreInstance
                              .collection('courses')
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData) {
                              return Center(
                                child: new CircularProgressIndicator(),
                              );
                            }
                            List<String> courseList = [];
                            List<String> groupList = [];
                            List<String> semList = [];

                            for (int i = 0;
                                i < snapshots.data.documents.length;
                                i++) {
                              courseList.add(
                                  '${snapshots.data.documents[i].data()['cName']}');
                            }

                            for (int i = 0;
                                i < snapshots.data.documents.length;
                                i++) {
                              for (int j = 0;
                                  j <
                                      snapshots.data.documents[i]
                                          .data()['cScheme']['branches']
                                          .length;
                                  j++) {
                                if (snapshots.data.documents[i]
                                        .data()['cName'] ==
                                    course) {
                                  groupList.add(snapshots.data.documents[i]
                                      .data()['cScheme']['branches'][j]);
                                }
                              }
                            }

                            for (int i = 0;
                                i < snapshots.data.documents.length;
                                i++) {
                              if (snapshots.data.documents[i].data()['cName'] ==
                                  course) {
                                if (snapshots.data.documents[i]
                                        .data()['cScheme']['totalSem'] ==
                                    4) {
                                  semList.add('I');
                                  semList.add('II');
                                  semList.add('III');
                                  semList.add('IV');
                                } else if (snapshots.data.documents[i]
                                        .data()['cScheme']['totalSem'] ==
                                    6) {
                                  semList.add('I');
                                  semList.add('II');
                                  semList.add('III');
                                  semList.add('IV');
                                  semList.add('V');
                                  semList.add('VI');
                                } else if (snapshots.data.documents[i]
                                        .data()['cScheme']['totalSem'] ==
                                    8) {
                                  semList.add('I');
                                  semList.add('II');
                                  semList.add('III');
                                  semList.add('IV');
                                  semList.add('V');
                                  semList.add('VI');
                                  semList.add('VII');
                                  semList.add('VIII');
                                }
                              }
                            }
                            debugPrint(
                                '${snapshots.data.documents[0].data()['cScheme']['branches'].length} @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                            return new /* Card(
                              child: Container(
                                child: ListView.builder(
                                    itemCount: snapshots.data.documents.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot data =
                                          snapshots.data.documents[index];
                                      return Card(
                                        child: Text('${data.data()['cName']}'),
                                      );
                                    }),
                              ),
                            );*/
                                Container(
                              child: ChangeNotifierProvider<SetUpModel>(
                                create: (context) => SetUpModel(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 30),
                                        Text(
                                          'Course: ',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.deepPurpleAccent,
                                          ),
                                        ),
                                        Consumer<SetUpModel>(
                                          builder:
                                              (context, setUpModel, child) {
                                            /*setUpModel
                                                .chngCurCourse(courseList[0]);*/
                                            return DropdownButton(
                                              value: setUpModel.curCourse,
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(
                                                fontFamily: 'Typewriter',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              items: courseList.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String newCourse) {
                                                setUpModel
                                                    .chngCurCourse(newCourse);
                                                setState(() {
                                                  course = newCourse;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 30),
                                        Text(
                                          'Group: ',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.deepPurpleAccent,
                                          ),
                                        ),
                                        Consumer<SetUpModel>(
                                          builder:
                                              (context, setUpModel, child) {
                                            setUpModel
                                                .chngCurSubComb(groupList[0]);
                                            return DropdownButton(
                                              value: setUpModel.curSubComb,
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(
                                                fontFamily: 'Typewriter',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              items: groupList.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String newSubComb) {
                                                setUpModel
                                                    .chngCurSubComb(newSubComb);
                                                setState(() {
                                                  group = newSubComb;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 30),
                                        Text(
                                          'Sem: ',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.deepPurpleAccent,
                                          ),
                                        ),
                                        Consumer<SetUpModel>(
                                          builder:
                                              (context, setUpModel, child) {
                                            setUpModel.chngCurSem(semList[0]);
                                            return DropdownButton(
                                              value: setUpModel.curSem,
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(
                                                fontFamily: 'Typewriter',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              items: semList.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String newSem) {
                                                setUpModel.chngCurSem(newSem);
                                                setState(() {
                                                  sem = newSem;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    RaisedButton(
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 24,
                                          ),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            // userIdStatus.courseSetUpStatus(true);
                                            isLoading = true;
                                          });
                                          dynamic result =
                                              await _fsService.setCourse(
                                                  cUser, course, group, sem);
                                          if (result == true) {
                                            if (svm.getCourseFlag()) {
                                              Navigator.of(context).pop();
                                            } else {
                                              await _addCourseFlagToSF();
                                              await svm.setCourseFlag(true);
                                            }
                                            showToast(
                                                ' Course set up successful. ',
                                                textStyle: TextStyle(
                                                    fontFamily: 'Nunito'),
                                                position: ToastPosition.bottom);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: size.height * 0.15,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "In future you can CHANGE this SET UP through SETTINGS menu.",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ));
  }
}
