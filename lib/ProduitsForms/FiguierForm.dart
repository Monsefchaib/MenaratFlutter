import 'package:flutter/material.dart';

class FiguierForm extends StatefulWidget {
  @override
  _FiguierFormState createState() => _FiguierFormState();
}

class _FiguierFormState extends State<FiguierForm> {
  var _locations = ['','ORNAXI', 'GHODAN', 'ANBER ABYAD', 'AIN LHAJLA',"KAPERFIGUIER",'NABOUT','SARILOP','KASBATE SKHIRATE','COUL DE DAM','CHETOUI','EL QUOTIE BYAD','AMEZIANE','KADOTA'];
  String selectedLocation = '';
  String _substratValue = '';
  String _conteneurValue = '';
  var susbtrat=['','SOL','TOURBE'];
  var conteneur=['','POT','SACHET'];
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      shrinkWrap: true,
      children: <Widget>[

        InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: 'Espèce',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child:DropdownButton<String>(
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
                  (index) => DropdownMenuItem(
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
        ElevatedButton(onPressed: () {  },
          child: Text('Ajouter'),

        ),
      ],
    );
  }
}
