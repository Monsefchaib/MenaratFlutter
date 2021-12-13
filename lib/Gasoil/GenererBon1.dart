import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:suiviventes/Models/vehicule.dart';

import '../constants.dart';

class GenererBon2 extends StatefulWidget {
  @override
  _GenererBon2State createState() => _GenererBon2State();
}

class _GenererBon2State extends State<GenererBon2> {
  @override
  void initState() {
    super.initState();
    _getStateList();

  }
Vehicule vehiculeChoisie = Vehicule("","","");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
    ),
    body: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    Container(
    alignment: Alignment.topCenter,
    margin: EdgeInsets.only(bottom: 100, top: 100),
    child: Text(
    'KDTechs',
    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
    ),
    ),
    //======================================================== State

    Container(
    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
    color: Colors.white,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Expanded(
    child: DropdownButtonHideUnderline(
    child: ButtonTheme(
    alignedDropdown: true,
    child: DropdownButton<Vehicule>(
    value: vehiculeChoisie,
    iconSize: 30,
    icon: (null),
    style: TextStyle(
    color: Colors.black54,
    fontSize: 16,
    ),
    hint: Text('Select State'),
    onChanged: (Vehicule? newValue) {
    setState(() {
    vehiculeChoisie = newValue!;
    // _getCitiesList();
    print(vehiculeChoisie);
    });
    },
    items: statesList?.map((vehicule) {
    return new DropdownMenuItem<Vehicule>(
    child: new Text(vehicule.nomVehicule),
    value: vehicule,
    );
    })?.toList() ??
    [],
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    SizedBox(
    height: 30,
    )
    ]),
    );

  }












// -------------------------------------

  List? statesList;
  String? _myState;

  Future<List<Vehicule>> _getStateList() async {
    List<Vehicule> listMapped;
    final url = Uri.parse('http://$urlApi:3000/vehicules');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List vehicules = json.decode(response.body);
      listMapped =  vehicules.map((json) => Vehicule.fromJson(json)).toList();
      setState(() {
        statesList = listMapped;
        vehiculeChoisie=listMapped[0];
        print(vehiculeChoisie);
      });
      return listMapped;
    } else {
      throw Exception();
    }
  }


}




