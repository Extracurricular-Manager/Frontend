import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_data_classes/user.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser() async {
  final response = await http.get(
    Uri.parse('http://148.60.11.219/api/user/admin'),
    headers: {
      'authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOIiwiZXhwIjoxNjQ1NzA4OTk3fQ.UTov0-HQgl13Oecw_5kTxzy2jDK-l2_EaU3_eZnp7mrD5mSJ3ZZBKrvexoMiKUkT1ycsYYKJRWzNw7-Qq3s5ZA',
    },
  );

  if (response.statusCode == 200) {
    print(response.body);
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch user',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch me a user'),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Name:  " +
                    snapshot.data!.name.toString() +
                    ", Login:  " +
                    snapshot.data!.login.toString() +
                    ", activated: " +
                    snapshot.data!.activated.toString());
              } else if (snapshot.hasError) {
                return Text("test " + '${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
