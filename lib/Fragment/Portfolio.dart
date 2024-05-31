import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Portfolio extends StatelessWidget {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Showcase"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        color: Colors.blueGrey[900],
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CHECK THE PROJECTS ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: SizedBox(height: 20),
            ),
            PortfolioItem(
              projectName: "Machine-Learning-project-for-AI",
              projectLink:
                  "https://github.com/kaif15-14682/Machine-Learning-project-for-AI",
              projectDescription:
                  "This project focuses on developing machine learning models to tackle real-world problems. It includes data collection, preprocessing, model training, and evaluation. Using algorithms like neural networks and decision trees, the project aims to build accurate predictive models for applications such as image recognition, natural language processing, and predictive analytics.",
            ),
            Center(
              child: SizedBox(height: 20),
            ),
            PortfolioItem(
              projectName: "Password-manager-app",
              projectLink:
                  "https://github.com/kaif15-14682/Password-manager-using-bash",
              projectDescription:
                  "This project involves creating a password manager using Bash scripting. It allows users to securely store and manage their passwords from the command line interface. The app encrypts passwords before storing them in a file, ensuring data security. Users can add, retrieve, update, and delete passwords, all within the terminal environment. Additionally, the app may include features like password generation, search functionality, and master password authentication for added security.",
            ),
            Center(
              child: SizedBox(height: 20),
            ),
            PortfolioItem(
              projectName: "DOCTOR AID",
              projectLink: "https://github.com/kaif15-14682/DoctorAid2",
              projectDescription:
                  "A medical app for remote consultations, appointment scheduling, and health tracking.",
            ),
            Spacer(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      color: Color.fromARGB(255, 10, 177, 255),
                      size: 40,
                    ),
                    onPressed: () {
                      _launchURL('https://github.com/kaif15-14682');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Color.fromARGB(255, 10, 177, 255),
                      size: 40,
                    ),
                    onPressed: () {
                      _launchURL('https://www.facebook.com/sheikh.kaif.58');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Color.fromARGB(255, 10, 177, 255),
                      size: 40,
                    ),
                    onPressed: () {
                      _launchURL(
                          'https://www.linkedin.com/in/sheikh-kaif-5bb86720b/');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Color.fromARGB(255, 10, 177, 255),
                      size: 40,
                    ),
                    onPressed: () {
                      _launchURL('https://www.instagram.com/futus.mutus/');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.telegram,
                      color: Color.fromARGB(255, 10, 177, 255),
                      size: 40,
                    ),
                    onPressed: () {
                      _launchURL('https://web.telegram.org/k/');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PortfolioItem extends StatelessWidget {
  final String projectName;
  final String projectLink;
  final String projectDescription;

  const PortfolioItem({
    required this.projectName,
    required this.projectLink,
    required this.projectDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            projectName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            projectDescription,
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              // Handle link tap
              _launchURL(projectLink);
            },
            child: Text(
              projectLink,
              style: TextStyle(
                color: Colors.teal,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
