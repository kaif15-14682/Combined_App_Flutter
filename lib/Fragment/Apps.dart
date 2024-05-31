import 'package:flutter/material.dart';
import 'package:interf/Fragment/CalculatorScreen.dart';
import 'package:interf/Fragment/LoginPage.dart';
import 'package:interf/Fragment/Portfolio.dart';
import 'home_page.dart';

class Apps extends StatelessWidget {
  const Apps({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255,
            255), // Change this to your preferred background color
        child: ListView(
          children: [
            AppListItem(
              appName: "Quiz App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icons.question_answer,
              iconColor:
                  Color.fromARGB(255, 0, 0, 0), // Customize the icon color
            ),
            AppListItem(
              appName: "Weather App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: Icons.cloud,
              iconColor:
                  Color.fromARGB(255, 0, 0, 0), // Customize the icon color
            ),
            AppListItem(
              appName: "Calculator App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorScreen()),
                );
              },
              icon: Icons.calculate,
              iconColor:
                  Color.fromARGB(255, 0, 0, 0), // Customize the icon color
            ),
            AppListItem(
              appName: "Project Showcase",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Portfolio()),
                );
              },
              icon: Icons.person,
              iconColor:
                  Color.fromARGB(255, 0, 0, 0), // Customize the icon color
            ),
            // Add more AppListItems as needed
          ],
        ),
      ),
    );
  }
}

class AppListItem extends StatelessWidget {
  final String appName;
  final Function onTap;
  final IconData icon;
  final Color iconColor;

  const AppListItem({
    required this.appName,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(
          255, 255, 252, 252), // Customize the card background color
      elevation: 4, // Add elevation for a subtle shadow
      margin: EdgeInsets.all(10), // Add margin for spacing
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(
            icon,
            color: Colors.white, // Customize the icon color
          ),
        ),
        title: Text(
          appName,
          style: TextStyle(color: Colors.black), // Customize the text color
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
