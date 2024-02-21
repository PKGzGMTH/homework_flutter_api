import 'dart:convert';

import 'package:homework_api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List> getAllUsers() async {
    List users = [];
    var res = await http.get(Uri.https("fakestoreapi.com", "users"));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      for (var i in data) {
        users.add(Users(
            id: i['id'],
            fname: i['name']['firstname'],
            lname: i['name']['lastname'],
            email: i['email'],
            phone: i['phone'],
            city: i['address']['city']
        ));
      }
      return users;
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Call"),
      ),
      body: FutureBuilder(
        future: getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].fname + ' ' + snapshot.data![index].lname),
                            subtitle: Text('Email: ' + snapshot.data![index].email + '\nTel: ' + snapshot.data![index].phone),
                            leading: const Icon(Icons.person),
                            trailing:
                                Text(snapshot.data![index].city),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot.data!.length),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
