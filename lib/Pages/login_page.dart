import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool obsecureText = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late SharedPreferences sharedPreferences;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    newUser = (sharedPreferences.getBool('login') ?? true); // Add "?"
    print(newUser);
    if (newUser == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TeamListPage()));
    }
  }

  String calculateMD5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  void printHashForAdminPassword() {
    String hashedPassword = calculateMD5('carlos');
    print('Hashed Password: $hashedPassword');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 450,
              width: 400,
              child: Card(
                color: Colors.teal[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          floatingLabelStyle: TextStyle(
                              color: Colors.grey[700]
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey[700]!
                            ),
                          ),
                          labelText: 'Username',
                          hintText: 'Enter your Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                        cursorColor: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: obsecureText,
                        decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[700]
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey[700]!
                                )
                            ),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsecureText = !obsecureText;
                                  });
                                },
                                icon: Icon(
                                  obsecureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey[600],
                                )
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15)
                        ),
                        cursorColor: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          sharedPreferences.setBool('login', false);
                          sharedPreferences.setString(
                              'username', _usernameController.text);
                          if (_usernameController.text == 'carlos' &&
                              _passwordController.text == 'carlos') {
                            printHashForAdminPassword();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TeamListPage()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Login Success'),
                              backgroundColor: Colors.green,
                            ));
                          } else {
                            String hashedPassword =
                            calculateMD5(_passwordController.text);
                            print('Hashed Password: $hashedPassword');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Login Failed'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
