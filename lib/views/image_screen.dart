import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_apod_api_test/models/apod.dart';


class NasaApoodImageDisplay extends StatefulWidget {
  const NasaApoodImageDisplay({Key? key}) : super(key: key);

  @override
  State<NasaApoodImageDisplay> createState() => _NasaApoodImageDisplayState();
}

class _NasaApoodImageDisplayState extends State<NasaApoodImageDisplay> {
  final TextEditingController _controller = TextEditingController();
  List<Apod> jsonList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Display Apod',
          style: TextStyle(backgroundColor: Colors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: const Text('Submit'),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: jsonList.isNotEmpty
                    ? Image.network(jsonList[0].url)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String apiKey = 'K3B4TMq19PEFVsRfg3dZ5tZQbdBtMMpcSXnSdsVR';

  Future<void> getData() async {
    String date = _controller.text.trim();
    if (date.isNotEmpty) {
      final response = await http.get(
        Uri.parse('https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$date'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          jsonList.clear();
          jsonList.add(Apod.fromJson(data));
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } 
  }
}
