import 'package:carlos_teori/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Model/user_model.dart'; // Adjust the import path

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Text('Signup Page'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Username',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.teal[300]!
                      )
                  ),
                ),
                cursorColor: Colors.teal[300],
              ),
              SizedBox(height: 16.0),
              Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Masukkan Password',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.teal[300]!
                      )
                  ),
                ),
                cursorColor: Colors.teal[300],
              ),
              SizedBox(height: 16.0),
              Text(
                'Nama Depan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Nama Depan',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.teal[300]!
                      )
                  ),
                ),
                cursorColor: Colors.teal[300],
              ),
              SizedBox(height: 16.0),
              Text(
                'Nama Belakang',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Nama Belakang',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.teal[300]!
                      )
                  ),
                ),
                cursorColor: Colors.teal[300],
              ),
              SizedBox(height: 16.0),
              Text(
                'NIM',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nimController,
                decoration: InputDecoration(
                  hintText: 'Masukkan NIM',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.teal[300]!
                      )
                  ),
                ),
                cursorColor: Colors.teal[300],
              ),
              SizedBox(height: 16.0),
              Text(
                'Tempat Lahir',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: placeOfBirthController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Tempat Lahir',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.teal[300]!
                      )
                  ),
                ),
                cursorColor: Colors.teal[300],
              ),
              SizedBox(height: 16.0),
              Text(
                'Tanggal Lahir',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: dateOfBirthController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Tanggal Lahir (Tanggal Bulan Tahun)',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.teal[300]!
                      )
                  ),
                ),
                cursorColor: Colors.teal[300],
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  // Create a user object with the entered data
                  User newUser = User()
                    ..username = usernameController.text
                    ..password = passwordController.text
                    ..firstName = firstNameController.text
                    ..lastName = lastNameController.text
                    ..nim = nimController.text
                    ..placeOfBirth = placeOfBirthController.text
                    ..dateOfBirth = dateOfBirthController.text;

                  // Get the Hive user box from the service
                  var userBox = HiveService.getUserBox();

                  // Add the user to the box
                  await userBox.add(newUser);

                  // Retrieve the user list from the box (for testing)
                  List<User> userList = userBox.values.toList();
                  print('User List: $userList');
                },
                child: Text('Sign Up'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.teal[300]!),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(color: Colors.grey[600])),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Log In', style: TextStyle(color: Colors.teal[400])),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HiveService {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('userBox');
  }

  static Box<User> getUserBox() {
    return Hive.box<User>('userBox');
  }
}
