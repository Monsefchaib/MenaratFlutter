import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/AfficherCommandes/CommandesEnCours.dart';
import 'package:suiviventes/AjoutCommande/AfficherCommandes/CommandesFinalise.dart';

class AfficherCommandes extends StatefulWidget {
  @override
  _AfficherCommandesState createState() => _AfficherCommandesState();
}

class _AfficherCommandesState extends State<AfficherCommandes> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Afficher les commandes"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Commandes en cours"),
                Tab(text: "Commandes finalisés"),
              ],
            ),
          ),
          body: TabBarView(
              children: <Widget>[
                CommandesEnCours(),
                CommandesFinalise(),
              ]),
        ),
      length: 2,
      initialIndex: 0,
    );
  }
}
