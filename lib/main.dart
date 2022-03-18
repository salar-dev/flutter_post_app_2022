import 'package:flutter/material.dart';
import 'package:flutter_post/screens/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

// This project by Salar Brefki
//برمجة وتطوير سالار بريفكي
// YouTube: https://www.youtube.com/channel/UCphD-Ww9JnrBXRfzy6Ivg0g
// Facebook: https://www.facebook.com/salar.brefki
//Instagram: https://www.instagram.com/salarbrefki

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsScreen(),
    );
  }
}