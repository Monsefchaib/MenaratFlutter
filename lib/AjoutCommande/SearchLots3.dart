import 'package:flutter/material.dart';

class SearchLot extends StatefulWidget {
  @override
  _SearchLotState createState() => _SearchLotState();
}

class _SearchLotState extends State<SearchLot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recherche les lots"),
      ),
    );
  }
}
