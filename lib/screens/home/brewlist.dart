import 'package:coffeeCup/models/brew.dart';
import 'package:coffeeCup/screens/home/brewtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    //accessing the data from the stream throught the provider
    final brews = Provider.of<List<Brew>>(context) ?? [];
    brews.forEach((brew) {
      print(brew.name);
      print(brew.strength);
      print(brew.sugar);
    });
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        });
  }
}
