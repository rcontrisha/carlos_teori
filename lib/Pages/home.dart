import 'package:carlos_teori/Pages/converter.dart';
import 'package:carlos_teori/Pages/detail_page.dart';
import 'package:carlos_teori/Pages/feedback.dart';
import 'package:carlos_teori/Pages/profile.dart';
import 'package:flutter/material.dart';
import '../base_network.dart';
import '../Model/model.dart';

class TeamListPage extends StatefulWidget {
  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    TeamListPage(),
    Converter(),
    FeedbackForm(),
    ProfilePage(),
  ];

  final SportsApiClient sportsApiClient = SportsApiClient();
  late List<Teams> teams;

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the method to fetch data when the page is initialized
  }

  Future<void> fetchData() async {
    try {
      final data = await sportsApiClient.fetchData();
      final teamModel = TeamModel.fromJson(data); // Assuming you have a TeamModel model class

      setState(() {
        teams = teamModel.teams ?? [];
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error, show a message to the user, or retry the request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Team List'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: teams != null
          ? Padding(
            padding: const EdgeInsets.all(5),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Set the number of columns in the grid
                  crossAxisSpacing: 8.0, // Set the spacing between columns
                  mainAxisSpacing: 8.0, // Set the spacing between rows
                ),
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return Card(
                    color: Colors.teal[300],
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTeam(teams: team)));
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: team.strTeamBadge != null
                                ? Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Image.network(
                                      team.strTeamBadge!,
                                      fit: BoxFit.cover,
                                    ),
                                )
                                : Icon(Icons.sports_soccer),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              team.strTeam ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          )
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
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
