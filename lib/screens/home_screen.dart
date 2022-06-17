import 'package:assignment/models/employee_model.dart';
import 'package:assignment/services/employee_services.dart';
import 'package:assignment/user_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee_detail.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  String accessToken;
  HomeScreen({this.accessToken = 'No token'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EmployeeModel? employeeData;
  bool band1 = false;
  bool band2 = false;

  List<Results> band1List = [];
  List<Results> band2List = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Assignment'),
          actions: [
            GestureDetector(
              onTap: () {
                print('token = ' + widget.accessToken);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Add Employee"),
                ));
              },
              child: const Tooltip(
                message: "Add Employee",
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                UserSharedPreferences.setLoginStatus(false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()));
              },
              child: const Tooltip(
                message: 'logout',
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.logout),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Filter: '),
                  Text('0-50K'),
                  Checkbox(
                    value: band1,
                    onChanged: (newValue) {
                      setState(() {
                        band1 = newValue!;
                      });
                    },
                  ),
                  Text('50K - 150K'),
                  Checkbox(
                    value: band2,
                    onChanged: (newValue) {
                      setState(() {
                        band2 = newValue!;
                      });
                    },
                  ),
                ],
              ),
              FutureBuilder(
                  future: EmployeeServices().authenticate(widget.accessToken),
                  builder: (context, AsyncSnapshot<EmployeeModel> snapshot) {
                    band1List = [];
                    band2List = [];
                    if (snapshot.hasData) {
                      EmployeeModel? data = snapshot.data;
                      data!.results!.forEach((element) {
                        if (double.parse(element.salary!) / 12 <= 50000) {
                          band1List.add(element);
                        } else {
                          band2List.add(element);
                        }
                      });
                      if (band1) {
                        if (band2) {
                          return EmployeeListWidget(list: data.results);
                        } else {
                          return EmployeeListWidget(list: band1List);
                        }
                      }
                      if (band2) {
                        if (band1) {
                          return EmployeeListWidget(list: data.results);
                        } else {
                          return EmployeeListWidget(list: band2List);
                        }
                      }
                      return EmployeeListWidget(list: data.results);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ));
  }

  void getData() async {
    employeeData = await EmployeeServices().authenticate(widget.accessToken);
  }
}

class EmployeeListWidget extends StatelessWidget {
  const EmployeeListWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Results>? list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list!.length,
        itemBuilder: (context, index) {
          Results singleData = list![index];
          return Container(
            padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailScreen(
                        fullScreen: singleData.photo != null
                            ? Image(image: NetworkImage(singleData.photo!))
                            : const Image(
                                image: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                                fit: BoxFit.cover,
                              ),
                      );
                    }));
                  },
                  child: Hero(
                    tag: 'Image',
                    child: Container(
                      height: 150,
                      width: 100,
                      color: Colors.black12,
                      child: singleData.photo != null
                          ? Image(image: NetworkImage(singleData.photo!))
                          : const Image(
                              image: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeDetail(
                                  data: singleData,
                                )));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Name: ' +
                          singleData.firstName! +
                          ' ' +
                          singleData.lastName!),
                      Text('Designation: ' + singleData.designation!),
                      Text('Email: ' + singleData.email!),
                      Text('Salary: ' + singleData.salary!),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeDetail(
                                  data: singleData,
                                )));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(CupertinoIcons.forward),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class DetailScreen extends StatelessWidget {
  Widget? fullScreen;
  DetailScreen({this.fullScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
          tag: 'Image',
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: fullScreen!,
            ),
          ),
        ),
      ),
    );
  }
}
