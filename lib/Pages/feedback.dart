import 'package:carlos_teori/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../Model/feedback_model.dart';
import 'home.dart';
import 'converter.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  late int _currentIndex = 2;

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
        child: Expanded(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<FeedbackModel>('feedbackBoxCarlos').listenable(),
            builder: (BuildContext context, Box<FeedbackModel> box, _) {
              if (box.values.isEmpty) {
                return Center(
                  child: Text('Feedback is empty.', style: TextStyle(color: Colors.white, fontSize: 18)),
                );
              }
              return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  FeedbackModel? feedback = box.getAt(index);
                  return Card(
                    elevation: 3,
                    color: Colors.teal[200],
                    margin: EdgeInsets.all(6),
                    child: ListTile(
                      leading: Icon(Icons.chat_outlined),
                      title: Text('Kesan: ${feedback?.kesan}'),
                      subtitle: Text('Saran: ${feedback?.saran}'),
                    ),
                  );
                },
              );
            },
          ),
        )
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
}
