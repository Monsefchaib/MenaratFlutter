import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Produits.dart';

class AmandierForm extends StatefulWidget {
  @override
  _AmandierFormState createState() => _AmandierFormState();
}

class _AmandierFormState extends State<AmandierForm> {
  var _locations = [
    '',
    'MARCONA',
    'FOURNAT',
    'FERRADUEL',
    'FERRANGNES',
    "LAURAINE",
    "MANDALINE",
    "TUNONO"
  ];
  String selectedLocation = '';
  String _porteGreffeValue='';
  var porteGreffe = ['','GF 677','FRANC','GARNEM'];
  String _substratValue = '';
  String _conteneurValue = '';
  var susbtrat=['','SOL','TOURBE'];
  var conteneur=['','POT','SACHET'];


  final FnbrPlantes = TextEditingController();
  final FprixUnitaire = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        children: <Widget>[
          InputDecorator(
          decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 15.0),
          labelText: 'Variété',
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: DropdownButtonHideUnderline(
          child:
          DropdownButton<String>(
            isExpanded: true,
            value: selectedLocation,
            icon: const Icon(Icons.arrow_circle_down),
            iconSize: 20,
            elevation: 16,
            underline: Container(),
            onChanged: (String? newValue) {
              setState(() {
                selectedLocation = newValue!;
                print(selectedLocation);
              });
            },
            items: List.generate(
              _locations.length,
                  (index) =>
                  DropdownMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          _locations[index]
                      ),
                    ),
                    value: _locations[index],
                  ),
            ),
          ),
          ),
          ),
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Porte Greffe',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            child:DropdownButton<String>(
              isExpanded: true,
              value: _porteGreffeValue,
              icon: const Icon(Icons.arrow_circle_down),
              iconSize: 20,
              elevation: 16,
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  _porteGreffeValue = newValue!;
                  print(_porteGreffeValue);
                });
              },
              items: List.generate(
                porteGreffe.length,
                    (index) => DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        porteGreffe[index]
                    ),
                  ),
                  value: porteGreffe[index],
                ),
              ),
            ),
          ),
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Substrat',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            child:DropdownButton<String>(
              isExpanded: true,
              value: _substratValue,
              icon: const Icon(Icons.arrow_circle_down),
              iconSize: 20,
              elevation: 16,
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  _substratValue = newValue!;
                  print(_substratValue);
                });
              },
              items: List.generate(
                susbtrat.length,
                    (index) => DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        susbtrat[index]
                    ),
                  ),
                  value: susbtrat[index],
                ),
              ),
            ),
          ),
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Conteneur',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            child:DropdownButton<String>(
              isExpanded: true,
              value: _conteneurValue,
              icon: const Icon(Icons.arrow_circle_down),
              iconSize: 20,
              elevation: 16,
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  _conteneurValue = newValue!;
                  print(_conteneurValue);
                });
              },
              items: List.generate(
                conteneur.length,
                    (index) => DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        conteneur[index]
                    ),
                  ),
                  value: conteneur[index],
                ),
              ),
            ),
          ),
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          TextFormField(
            controller: FnbrPlantes,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Nombre de plantes',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            onChanged: (String? value){
              print(value);
            },
          ),
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          TextFormField(
            controller: FprixUnitaire,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Prix Unitaire',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            onChanged: (String? value){
              print(value);
            },
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
            Produit produit = Produit("Amandier",selectedLocation,_substratValue,_conteneurValue,int.parse(FnbrPlantes.text),double.parse(FprixUnitaire.text),_porteGreffeValue);
            Navigator.pop(context, produit);

          },
            child: Text('Ajouter'),

          ),


        ],
      ),
    );
  }
}
