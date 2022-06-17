import 'package:assignment/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/employee_model.dart';
import '../user_shared_preferences.dart';

class EmployeeDetail extends StatefulWidget {
  final Results data;

  EmployeeDetail({required this.data});

  @override
  State<EmployeeDetail> createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
        actions: [
          GestureDetector(
            onTap: () {
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
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 250,
                width: 250,
                color: Colors.black12,
                child: widget.data.photo != null
                    ? Image(image: NetworkImage(widget.data.photo!))
                    : Center(child: Text('No Image')),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                card(
                    'Name: ' +
                        widget.data.firstName! +
                        ' ' +
                        widget.data.lastName!,
                    Icons.person),
                card('Designation: ' + widget.data.designation!, Icons.badge),
                card('Email: ' + widget.data.email!, Icons.email),
                card('Phone Number: ' + widget.data.phone!, Icons.phone),
                card('DOB: ' + widget.data.dob!, Icons.celebration),
                card('Hire Date: ' + widget.data.hireDate!, Icons.person_pin),
                card('Address: ' + widget.data.address!, Icons.map),
                card('City: ' + widget.data.city!, Icons.location_city),
                card('Zip Code: ' + widget.data.zipCode!,
                    CupertinoIcons.map_pin),
                card(
                  'Country: ' + widget.data.country!,
                  CupertinoIcons.map_pin_ellipse,
                ),
                card('Salary: ' + widget.data.salary!,
                    CupertinoIcons.money_dollar),
                card('Organization Name: ' + widget.data.organizationName!,
                    CupertinoIcons.building_2_fill),
                card('Status: ' + widget.data.status!,
                    Icons.switch_account_sharp),
              ],
            )
          ],
        ),
      ),
    );
  }

  card(String title, IconData icon) {
    return Card(
      child: ListTile(dense: true, title: Text(title), leading: Icon(icon)),
    );
  }
}
