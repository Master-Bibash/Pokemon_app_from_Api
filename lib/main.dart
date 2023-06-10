import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/pokeDetail.dart';
import 'package:pokemonapp/pokemon.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pokemon App",
      theme: ThemeData(
        // primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    ));

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub? pokeHub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(
      Uri.parse(url),
    );
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    // print(pokeHub!.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("Pokemon App"),
        elevation: 0,
        centerTitle: true,
      ),
      body: pokeHub==null? Center(
        child: CircularProgressIndicator()
      ) :Padding(
        padding: const EdgeInsets.all(2.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: pokeHub?.pokemon
                  ?.map((Pokemon p) => 
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                       MaterialPageRoute(
                        builder: (context) => PokeDetail(
                          pokemon: p,
                        ),));
                    },
                    child: Card(
                          elevation: 3.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: (p.img).toString(),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage((p.img).toString()),
                                    )),
                                  ),
                                ),
                              ),
                              Text(
                                (p.name).toString(),
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                  ))
                  .toList() ??
              [],
        ),
      ),
      drawer: Drawer(),
     
    );
  }
}
