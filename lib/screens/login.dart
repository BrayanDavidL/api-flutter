import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null){
      _saveAndRedirectToHome(response.data as User);
    }
    else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: const Color(0xff69e2ff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(300),
                bottomRight: Radius.circular(300),
              ),
              border: Border.all(width: 3.0, color: const Color(0xff000000),),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 20,
            child: Column(
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 60,
                    fontFamily: 'Agency FB',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 70),
                Text(
                  'Please login to you account',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: ListView(
              padding: EdgeInsets.all(60),
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                    TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmail,
                    validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: txtPassword,
                        validator: (val) => val!.isEmpty ? 'Invalid password' : null,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      loading ? Center(child: CircularProgressIndicator()) :
                      kTextButton('Login', () {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                            _loginUser();
                          });
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  }