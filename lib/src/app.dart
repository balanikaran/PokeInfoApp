import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_info/src/models/pokemon.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Pokemon poke;
  final _r = Random();
  int _pokeNum;

  @override
  void initState() {
    super.initState();
    _pokeNum = 1 + _r.nextInt(600 - 1);
    this.getPoke();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Future<void> getPoke() async {
    String _baseUrl = "https://pokeapi.co/api/v2/pokemon/";
    _pokeNum = 1 + _r.nextInt(600 - 1);
    try {
      http.Response resp = await http.get(_baseUrl + _pokeNum.toString() + "/");
      Pokemon newPokemon = Pokemon.fromJson(jsonDecode(resp.body));
      setState(() {
        poke = newPokemon;
      });
    } catch (e) {
      return null;
    }
  }

  void _getNewPoke() {
    setState(() {
      poke = null;
    });
    getPoke();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData(
          fontFamily: 'Major Mono Display', backgroundColor: Colors.white),
      title: "Poke Info",
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Poke Info",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _bodyToShowPoke(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () => _getNewPoke(),
          icon: Icon(Icons.refresh),
          label: Text("Next", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _bodyToShowPoke() {
    return poke != null ? _withPoke() : _loadingPoke();
  }

  Widget _withPoke() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
      Container(
        width: 300.0,
        height: 300.0,
        alignment: Alignment.center,
        child: Image.network(poke.photoUrl, fit: BoxFit.cover),
      ),
      SizedBox(height: 30.0),
      Container(
        alignment: Alignment.center,
        child: Text(poke.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0)),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.center,
        child: Text("Base Experience: " + poke.baseExperience.toString(),
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      SizedBox(height: 20.0),
      Wrap(spacing: 20.0, alignment: WrapAlignment.center, children: <Widget>[
        Chip(
            backgroundColor: Colors.grey,
            label: Text("Height: " + poke.height.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            padding: EdgeInsets.all(8.0)),
        Chip(
            backgroundColor: Colors.grey,
            label: Text("Order: " + poke.order.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            padding: EdgeInsets.all(8.0)),
        Chip(
            backgroundColor: Colors.grey,
            label: Text(
              "Weight: " + poke.weight.toString(),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            padding: EdgeInsets.all(8.0)),
      ]),
    ]);
  }

  _loadingPoke() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent)),
          Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Make sure that you have an active internet connection!",
                textAlign: TextAlign.center,
              ))
        ]);
  }
}
