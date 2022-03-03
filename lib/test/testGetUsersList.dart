import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_data_classes/user.dart';
import 'package:http/http.dart';

Future<List<User>> getAllUsers() async {
//business logic to send data to server
  final Response response = await get(
    Uri.parse('http://148.60.11.219/api/users'),
    headers: {
      'authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOIiwiZXhwIjoxNjQ1NzA4OTk3fQ.UTov0-HQgl13Oecw_5kTxzy2jDK-l2_EaU3_eZnp7mrD5mSJ3ZZBKrvexoMiKUkT1ycsYYKJRWzNw7-Qq3s5ZA',
    },
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<User>((item) => User.fromJson(item)).toList();
  } else {
    throw Exception("Can't load users");
  }
}

class TestingGetUsersList extends StatefulWidget {
  const TestingGetUsersList({Key? key}) : super(key: key);

  @override
  _GetUsersListState createState() => _GetUsersListState();
}

class _GetUsersListState extends State<TestingGetUsersList> {
  late Future<List<User>> testUsers;

  @override
  void initState() {
    super.initState();
    setState(() {
      testUsers = getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing fetching users list'),
      ),
      body: FutureBuilder<List<User>>(
        future: testUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return Center(
                    child: ListTile(
                      title: Text("Name:  " +
                          snapshot.data![i].name.toString() +
                          ", Login:  " +
                          snapshot.data![i].login.toString()),
                    ),
                  );
                });
          } else if (!snapshot.hasData) {
            const Text("no users :((((");
          } else if (snapshot.hasError) {
            const Text('Snapshot error');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
