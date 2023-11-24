import 'package:carlos_teori/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Model/feedback_model.dart';
import 'home.dart';
import 'converter.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  late int _currentIndex = 2;
  final List<Widget> _screens = [
    TeamListPage(),
    Converter(),
    FeedbackForm(),
    ProfilePage(),
  ];

  final TextEditingController _saranController = TextEditingController();
  final TextEditingController _kesanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Form Saran dan Kesan'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
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
          } if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
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

  void submitFeedback() async {
    try {
      // Buka Hive box untuk feedback
      var feedbackBox = await Hive.openBox<FeedbackModel>('feedbackBox');

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
