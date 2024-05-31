// main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interf/Fragment/Blog.dart';
import 'package:provider/provider.dart';
import 'Fragment/personal_info_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Fragment/PersonalProfile.dart';
import 'Fragment/Apps.dart';
import 'Fragment/About.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PersonalInfoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeActivity(),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(221, 255, 255, 255),
        hintColor: const Color.fromARGB(221, 255, 255, 255),
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          subtitle1: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
          subtitle2: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class HomeActivity extends StatelessWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "PERVAPP",
            style: Theme.of(context).textTheme.headline6!,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.person, color: Color.fromARGB(255, 0, 0, 0)),
                text: 'About',
              ),
              Tab(
                icon: Icon(Icons.apps, color: Color.fromARGB(255, 0, 0, 0)),
                text: 'Apps',
              ),
              Tab(
                icon: Icon(Icons.upload_file,
                    color: Color.fromARGB(255, 0, 0, 0)),
                text: 'Upload your CV',
              ),
              Tab(
                icon:
                    Icon(Icons.assignment, color: Color.fromARGB(255, 0, 0, 0)),
                text: 'Blog',
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Color.fromARGB(133, 255, 255, 255),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(137, 255, 255, 255),
                  ),
                  child: UserAccountsDrawerHeader(
                    accountName: const Text(
                      "Sheikh Kaif",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    accountEmail: const Text(
                      "kaif15-14682@diu.edu.bd",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "lib/assets/gg.jpg",
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(136, 0, 0, 0),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // Add logic for Home onTap
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: Text(
                    'Gmail',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    launch('https://mail.google.com/mail');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.upload,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: Text(
                    'Upload Your CV',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.assignment,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: Text(
                    'Blog',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            About(),
            Apps(),
            PersonalProfile(),
            Blog(),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
