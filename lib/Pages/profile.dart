import 'package:carlos_teori/Pages/converter.dart';
import 'package:carlos_teori/Model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feedback.dart';
import 'home.dart';
import 'package:intl/intl.dart';
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
  User? user;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String username = prefs.getString('username') ?? '';

      // Open the Hive box
      var userBox = Hive.box<User>('userBox');

      // Find the user with the corresponding username
      var users =
          userBox.values.where((user) => user.username == username).toList();

      if (users.isNotEmpty) {
        // User found, use the first one
        user = users.first;
        setState(() {});
      } else {
        // User not found, handle accordingly (e.g., show an error message)
        print('User not found with username: $username');
      }
    } catch (e) {
      // Handle any potential errors, for now, print the error to the console
      print('Error loading user profile: $e');
    }
  }

  Future<void> _logout() async {
    // Clear the username from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');

    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  String formatBirthDate(DateTime date) {
    final formatter = DateFormat('d MMMM y', 'id_ID');
    return formatter.format(date);
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
      body: user != null
          ? Padding(
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
                          '${user!.firstName} ${user!.lastName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                      ),
                      Text(
                        '${user!.nim}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        '${user!.placeOfBirth}, ${(user!.dateOfBirth)}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          : Center(
              child: CircularProgressIndicator(),
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
          } if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Converter()),
            );
          } if (index == 2) {
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
              backgroundColor: Colors.teal[700]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.autorenew_rounded),
              label: 'Konversi',
              backgroundColor: Colors.teal[700]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined),
              label: 'Feedback',
              backgroundColor: Colors.teal[700]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              backgroundColor: Colors.teal[700]
          ),
        ],
      ),
    );
  }
}
