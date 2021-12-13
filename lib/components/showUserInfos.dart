import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Client.dart';

class ShowUserInfos extends StatefulWidget {
  @override
  _ShowUserInfosState createState() => _ShowUserInfosState();
}

class _ShowUserInfosState extends State<ShowUserInfos> {
  Client client = Client(" ."," ."," ."," .");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text("Nom :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
          Text(client.nom),
          Text("Prenom :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
          Text(client.prenom),
          Text("Telephone :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
          Text(client.telephone),
          Text("Adresse :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
          Text(client.adresse),
        ],

      ),
    );;
  }
}
