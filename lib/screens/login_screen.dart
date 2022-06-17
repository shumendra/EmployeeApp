import 'dart:convert';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/user_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:assignment/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailText = TextEditingController();
  TextEditingController pwdText = TextEditingController();

  bool _passwordVisible = false;
  String accessToken = '';

  bool isSignedIn = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      )),
                    ),

                    //Email field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      child: TextField(
                        controller: emailText,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                        ),
                      ),
                    ),

                    //Password field
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      child: TextField(
                        controller: pwdText,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    //Login Button
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          print(emailText.text + ' \n ' + pwdText.text);
                          var data =
                              await authenticate(emailText.text, pwdText.text);
                          if (data != null) {
                            isSignedIn = true;
                            isLoading = false;
                            UserSharedPreferences.setLoginStatus(isSignedIn);
                            UserSharedPreferences.setAccessToken(accessToken);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Login Success!"),
                            ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => HomeScreen(
                                          accessToken: accessToken,
                                        )));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Login failed! Please Try Again"),
                            ));
                            setState(() {
                              isLoading = false;
                            });
                          }
                          ;
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              ),
            ),
    );
  }

  authenticate(String email, String pass) async {
    var url =
        Uri.parse("https://api.equation.consolebit.com/api/v1/auth/login/");
    final response =
        await http.post(url, body: {"email": email, "password": pass});
    if (response.statusCode == 200) {
      LoginModel loginData = LoginModel.fromJson(jsonDecode(response.body));
      setState(() {
        accessToken = loginData.access!;
      });
      print('Success. Response = ${response.body}');
      return loginData;
    } else {
      return null;
    }
  }
}
