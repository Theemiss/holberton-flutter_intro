import 'package:flutter/material.dart';
import 'models.dart';

import "package:http/http.dart" as http;
import 'dart:convert';
import 'character_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  Future<List<Character>> fetchBbCharacters() async {
    List<Character> characList = [];
    final response = await http.get(
      Uri.parse('https://www.breakingbadapi.com/api/characters'),
    );
    var resJson = jsonDecode(response.body);
    for (var i = 0; i < resJson.length; i++) {
      final char = Character.fromJson(resJson[i]);
      characList.add(char);
    }
    return characList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Breaking Bad Quotes')),
      body: FutureBuilder(
        future: fetchBbCharacters(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error"),
                );
              } else {
                // print(snapshot.data[0])
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return (CharacterTile(
                      character: snapshot.data[index],
                    ));
                  },
                );
              }
          }
        },
      ),
    );
  }
}
