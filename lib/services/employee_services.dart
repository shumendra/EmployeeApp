import 'dart:convert';
import 'package:assignment/models/employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeeServices {
  Future<EmployeeModel> authenticate(String token) async {
    var url = Uri.parse(
        "https://api.equation.consolebit.com/api/v1/testing/employee/");
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      print('Employee response = ${response.body}');
      EmployeeModel data = EmployeeModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      print(response.statusCode);
      throw ('No data');
    }
  }
}
