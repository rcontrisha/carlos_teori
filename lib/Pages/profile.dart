import 'package:carlos_teori/Pages/converter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feedback.dart';
import 'home.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  final List<Widget> _screens = [
    TeamListPage(),
    Converter(),
    FeedbackForm(),
    ProfilePage(),
  ];

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
          child: Container(
            height: 350,
            width: 300,
            child: Card(
              color: Colors.teal[300],
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ClipOval(
                      child: Image.network(
                        'https://instagram.fjog3-1.fna.fbcdn.net/v/t51.2885-19/395226969_355443200384716_3040698718891801371_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fjog3-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=Xq-WFHGTjjQAX8BTR8Y&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBwaVpNqEp8ywinU_aRmJ5oHFNU5fSRX91Rpp4JJYdLQw&oe=65659F48&_nc_sid=8b3546',
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
}
