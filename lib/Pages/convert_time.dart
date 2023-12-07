import 'dart:async';

import 'package:carlos_teori/Pages/converter.dart';
import 'package:carlos_teori/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'converter.dart';
import 'feedback.dart';
import 'home.dart';

class TimeConverter extends StatefulWidget {
  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  int _currentIndex = 1;

  DateTime _selectedTime = DateTime.now();
  String timeZone = 'UTC';
  late DateTime _currentTime;

  String _formatTime(DateTime time, String timeZone) {
    return DateFormat('HH:mm:ss', 'en_US')
            .add_jm()
            .format(time.toUtc())
            .toString() +
        ' $timeZone';
  }

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
        _selectedTime = _selectedTime.add(Duration(seconds: 1));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Time Converter'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 400,
          child: Card(
            color: Colors.teal[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Waktu global (UTC):',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _formatTime(_currentTime, 'UTC'),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime = _currentTime.toUtc().add(Duration(hours: 7));
                          timeZone = 'WIB';
                        });
                      },
                      child: Text('WIB'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime = _currentTime.toUtc().add(Duration(hours: 8));
                          timeZone = 'WITA';
                        });
                      },
                      child: Text('WITA'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime = _currentTime.toUtc().add(Duration(hours: 9));
                          timeZone = 'WIT';
                        });
                      },
                      child: Text('WIT'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime = DateTime.now();
                          timeZone = 'GMT';
                        });
                      },
                      child: Text('London'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Text(
                  'Waktu yang dipilih:',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _formatTime(_selectedTime, timeZone),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ],
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
