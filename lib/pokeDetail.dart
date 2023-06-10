import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pokemonapp/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon? pokemon;

  PokeDetail({this.pokemon});

  Widget bodyWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  (pokemon?.name).toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Height:${pokemon?.height}",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Weight: ${pokemon?.weight}",
                  style: TextStyle(fontSize: 20),
                ),
             
                Text(
                  "Types",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon?.type
                          ?.map((type) => FilterChip(
                                backgroundColor: Colors.amber,
                                label: Text(type),
                                onSelected: (bool) {},
                              ))
                          ?.expand((w) => [
                                w,
                                const SizedBox(width: 4)
                              ]) // add spacing between FilterChips
                          ?.toList() ??
                      [],
                ),
                Text(
                  "Weakness",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon?.weaknesses
                          ?.map((type) => FilterChip(
                                backgroundColor: Colors.red,
                                label: Text(
                                  type,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onSelected: (bool) {},
                              ))
                          ?.expand((w) => [
                                w,
                                const SizedBox(width: 4)
                              ]) // add spacing between FilterChips
                          ?.toList() ??
                      [],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
              tag: (pokemon?.img).toString(),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage((pokemon?.img).toString()),
                        fit: BoxFit.cover)),
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text((pokemon!.name.toString())),
      ),
      body: bodyWidget(context),
    );
  }
}
