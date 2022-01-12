
import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Bons.dart';
import 'package:suiviventes/Models/vehicule.dart';

class AfficherJustificatif extends StatefulWidget {
  Bons bon;
  AfficherJustificatif(this.bon);
  @override
  _AfficherJustificatifState createState() => _AfficherJustificatifState(this.bon);
}

class _AfficherJustificatifState extends State<AfficherJustificatif> {
  Bons bon;
  _AfficherJustificatifState(this.bon);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(image: Vehicule.getImage(bon.justifUrl!),    fit: BoxFit.fill, // I thought this would fill up my Container but it doesn't

          ),
    ),
    );
  }
}
