

import 'package:flutter/material.dart';
import 'package:nasa_apod_api_test/views/image_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Display',
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
      ),
      home: const NasaApoodImageDisplay(),
    );
  }
}

