import 'package:carlos_teori/Pages/converter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/feedback_model.dart';
import 'feedback.dart';
import 'home.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  final TextEditingController _saranController = TextEditingController();
  final TextEditingController _kesanController = TextEditingController();

  Future<void> _logout() async {
    // Clear the username from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('login');

    // Navigate to the login page and remove the previous routes from the stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                height: 350,
                width: 300,
                child: Card(
                  color: Colors.teal[300],
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/carlos.jpg',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Carlos Nainggolan',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '124210045',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'Sidikalang, 1 Oktober 2001',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Saran:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    TextField(
                      controller: _saranController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Masukkan saran Anda...',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white)
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Kesan:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    TextField(
                      controller: _kesanController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: 'Masukkan kesan Anda...',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          hintStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white)
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        submitFeedback();
                      },
                      child: Text('Kirim'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal[300]!)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal[700],
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TeamListPage()),
            );
          }
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Converter()),
            );
          }
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FeedbackForm()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
              backgroundColor: Colors.teal[700]),
          BottomNavigationBarItem(
              icon: Icon(Icons.autorenew_rounded),
              label: 'Konversi',
              backgroundColor: Colors.teal[700]),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined),
              label: 'Feedback',
              backgroundColor: Colors.teal[700]),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              backgroundColor: Colors.teal[700]),
        ],
      ),
    );
  }

  void submitFeedback() async {
    try {
      // Buka Hive box untuk feedback
      var feedbackBox = await Hive.openBox<FeedbackModel>('feedbackBoxCarlos');

      // Buat objek FeedbackModel dari data yang dimasukkan
      FeedbackModel feedback = FeedbackModel(
        saran: _saranController.text,
        kesan: _kesanController.text,
      );

      // Simpan objek FeedbackModel ke dalam Hive box
      await feedbackBox.add(feedback);

      // Tampilkan pesan sukses atau lakukan sesuatu yang lain
      print('Feedback berhasil disimpan ke dalam Hive box.');
    } catch (e) {
      // Handle error jika ada
      print('Error: $e');
    }
  }
}
