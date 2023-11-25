import 'package:carlos_teori/Pages/converter.dart';
import 'package:carlos_teori/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'feedback.dart';
import 'home.dart';


class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    TeamListPage(),
    Converter(),
    FeedbackForm(),
    ProfilePage(),
    // Add your Log Out screen here
  ];

  TextEditingController amountController = TextEditingController();
  String selectedFromCurrency = 'USD';
  String selectedToCurrency = 'EUR';
  String convertedResult = '';

  Map<String, double> conversionRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.73,
    'JPY': 110.13,
    'CAD': 1.25,
    'AUD': 1.34,
    'IDR': 14247.50,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  labelStyle: TextStyle(
                      color: Colors.white
                  ),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  )
              ),
              cursorColor: Colors.white,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCurrencyDropdown(selectedFromCurrency, true),
                Text('to', style: TextStyle(color: Colors.white)),
                buildCurrencyDropdown(selectedToCurrency, false),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.teal[300]!)
              ),
              onPressed: () {
                convertCurrency();
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text('Converted Result: $convertedResult', style: TextStyle(color: Colors.white)),
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

  Widget buildCurrencyDropdown(String selectedValue, bool isFrom) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          if (isFrom) {
            selectedFromCurrency = newValue!;
          } else {
            selectedToCurrency = newValue!;
          }
        });
      },
      icon: Icon(Icons.arrow_drop_down, color: Colors.white), // Set the color to white
      items: conversionRates.keys
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void convertCurrency() {
    final double amount = double.tryParse(amountController.text) ?? 0.0;

    final double fromRate = conversionRates[selectedFromCurrency] ?? 1.0;
    final double toRate = conversionRates[selectedToCurrency] ?? 1.0;

    final double result = amount * (toRate / fromRate);

    setState(() {
      convertedResult = result.toStringAsFixed(2);
    });
  }
}
