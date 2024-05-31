import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'BlogWrite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.tealAccent),
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.teal.shade900,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            color: Colors.teal.shade700,
          ),
          bodyText1: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18,
            height: 1.5,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      home: const Blog(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Blog extends StatelessWidget {
  const Blog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: ListView(
        children: const [
          BlogPost(
            title: 'Exploring Quantum Computing',
            excerpt: 'Dive into the fascinating world of quantum computing...',
            content:
                'Quantum computing leverages the principles of quantum mechanics to perform computations at unprecedented speeds. Unlike classical computers that use bits, quantum computers use qubits, which can exist in multiple states simultaneously. This allows quantum computers to solve complex problems in seconds that would take classical computers millions of years. From cryptography to drug discovery, the potential applications of quantum computing are limitless. Join us as we explore the cutting-edge advancements in this revolutionary field...',
          ),
          BlogPost(
            title: 'The Future of Artificial Intelligence',
            excerpt: 'Discover how AI is transforming our world...',
            content:
                'Artificial Intelligence (AI) is no longer a concept of the future; it’s shaping our present. From self-driving cars to personalized recommendations on streaming services, AI is enhancing efficiency and creating new possibilities. The future promises even more innovations, with AI expected to revolutionize healthcare through predictive diagnostics, streamline industries with intelligent automation, and transform education with personalized learning experiences. Stay tuned as we delve into the exciting developments and ethical considerations surrounding AI...',
          ), // Add more BlogPost widgets as needed
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BlogWrite(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BlogPost extends StatelessWidget {
  final String title;
  final String excerpt;
  final String content;

  const BlogPost({
    required this.title,
    required this.excerpt,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          excerpt,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.teal),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetail(
                title: title,
                content: content,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BlogDetail extends StatelessWidget {
  final String title;
  final String content;

  const BlogDetail({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _shareContent(context, title, content);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }

  void _shareContent(BuildContext context, String title, String content) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      '$title\n\n$content',
      subject: title,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
