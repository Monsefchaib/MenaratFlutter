
import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/SuiviDesTraitements/TachesCompletes.dart';
import 'package:suiviventes/AjoutCommande/SuiviDesTraitements/TachesEnCours.dart';

class ListeDesTaches extends StatefulWidget {
  @override
  _ListeDesTachesState createState() => _ListeDesTachesState();
}

class _ListeDesTachesState extends State<ListeDesTaches> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Liste des tâches"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Tâche en cours"),
              Tab(text: "Tâche complètes"),
            ],
          ),
        ),
        body: TabBarView(
            children: <Widget>[
              TachesEnCours(),
              TachesCompeletes(),
            ]),
      ),
      length: 2,
      initialIndex: 0,
    );
  }
}
