import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: About(),
    debugShowCheckedModeBanner: false,
  ));
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 0, 0, 0), Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("lib/assets/pp.jpg"),
              ),
              SizedBox(height: 20),
              Text(
                "Sheikh Kaif",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: "Times New Roma",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              _buildInfoRow(Icons.school, "B.Sc in CSE", context),
              _buildInfoRow(Icons.note_add_rounded, "PortShowcase", context),
              _buildInfoRow(Icons.location_pin, "Dhanmondi, Dhaka", context),
              _buildInfoRow(Icons.email, "kaif15-14682@diu.edu.bd", context),
              _buildInfoRow(Icons.phone, "01630943003", context),
              SizedBox(height: 30),
              Text(
                "I am an enthusiastic Computer Science and Engineering student, possessing a deep knowledge of fundamental concepts such as programming, data structures, algorithms, and computer systems. My hands-on experience and academic studies have enabled me to develop proficiency in languages like Python, Java, and C++. With a commitment to staying up-to-date with the latest technological advancements, I actively participate in coding competitions, hackathons, and technical workshops to enhance my skills and knowledge..",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: "Times New Roma"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontFamily: "Times New Roma"),
          ),
        ],
      ),
    );
  }
}
